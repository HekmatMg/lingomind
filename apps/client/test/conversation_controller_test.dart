import 'package:flutter_test/flutter_test.dart';

import 'package:client/application/state/conversation_controller.dart';
import 'package:client/domain/entities/conversation_message.dart';
import 'package:client/domain/entities/error_correction.dart';
import 'package:client/domain/entities/scenario.dart';
import 'package:client/domain/services/conversation_engine.dart';
import 'package:client/domain/services/error_detector.dart';

class FakeConversationEngine implements ConversationEngine {
  @override
  ConversationMessage createOpeningMessage(Scenario scenario) {
    return const ConversationMessage(
      role: ConversationRole.teacher,
      text: 'Welcome.',
    );
  }

  @override
  ConversationMessage respondToLearner({
    required Scenario scenario,
    required String learnerText,
    required int turnNumber,
  }) {
    return ConversationMessage(
      role: ConversationRole.teacher,
      text: 'Teacher response $turnNumber',
    );
  }
}

class FakeErrorDetector implements ErrorDetector {
  @override
  ErrorCorrection? detect(String learnerText) {
    if (learnerText == 'I goed to school.') {
      return const ErrorCorrection(
        originalText: 'I goed to school.',
        explanation: 'Use went.',
        correctedText: 'I went to school.',
      );
    }
    return null;
  }
}

ConversationController createController() {
  return ConversationController(
    engine: FakeConversationEngine(),
    errorDetector: FakeErrorDetector(),
  );
}

void main() {
  const scenario = Scenario(
    id: 'test',
    title: 'Test scenario',
    description: 'Test description',
    level: 'A2',
    durationMinutes: 5,
  );

  test('starts with a teacher opening message', () {
    final controller = createController();

    controller.start(scenario);

    expect(controller.state, isNotNull);
    expect(controller.state!.messages, hasLength(1));
    expect(controller.state!.messages.first.role, ConversationRole.teacher);
    expect(controller.state!.messages.first.text, 'Welcome.');
  });

  test('adds learner and teacher messages for each turn', () {
    final controller = createController();

    controller.start(scenario);
    controller.sendLearnerMessage('Hello');

    expect(controller.state!.learnerTurnCount, 1);
    expect(controller.state!.messages, hasLength(3));
    expect(controller.state!.messages[1].role, ConversationRole.learner);
    expect(controller.state!.messages[1].text, 'Hello');
    expect(controller.state!.messages[2].text, 'Teacher response 1');
  });

  test('stores detected corrections', () {
    final controller = createController();

    controller.start(scenario);
    controller.sendLearnerMessage('I goed to school.');

    expect(controller.state!.corrections, hasLength(1));
    expect(controller.state!.corrections.first.correctedText, 'I went to school.');
  });

  test('ignores empty learner messages', () {
    final controller = createController();

    controller.start(scenario);
    controller.sendLearnerMessage('   ');

    expect(controller.state!.learnerTurnCount, 0);
    expect(controller.state!.messages, hasLength(1));
  });
}

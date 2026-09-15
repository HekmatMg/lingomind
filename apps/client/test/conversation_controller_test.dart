import 'package:flutter_test/flutter_test.dart';

import 'package:client/application/state/conversation_controller.dart';
import 'package:client/domain/entities/conversation_message.dart';
import 'package:client/domain/entities/error_correction.dart';
import 'package:client/domain/entities/scenario.dart';
import 'package:client/domain/services/conversation_engine.dart';
import 'package:client/domain/services/error_detector.dart';
import 'package:client/domain/services/teaching_brain.dart';

class FakeConversationEngine implements ConversationEngine {
  @override
  ConversationMessage createOpeningMessage(Scenario scenario) => const ConversationMessage(role: ConversationRole.teacher, text: 'Welcome.');

  @override
  ConversationMessage respondToLearner({required Scenario scenario, required String learnerText, required int turnNumber}) => ConversationMessage(role: ConversationRole.teacher, text: 'Teacher response $turnNumber');
}

class FakeErrorDetector implements ErrorDetector {
  @override
  ErrorCorrection? detect(String learnerText) => learnerText == 'I goed to school.'
      ? const ErrorCorrection(originalText: 'I goed to school.', explanation: 'Use went.', correctedText: 'I went to school.')
      : null;
}

class FakeTeachingBrain implements TeachingBrain {
  @override
  TeachingStrategy strategyFor({required String learnerLevel, required int recentCorrectionCount}) => const TeachingStrategy(
    correctionTiming: CorrectionTiming.immediate,
    questionStyle: TeachingQuestionStyle.open,
    useScaffolding: true,
  );
}

ConversationController createController() => ConversationController(
  engine: FakeConversationEngine(), errorDetector: FakeErrorDetector(), teachingBrain: FakeTeachingBrain(), learnerLevel: 'A2',
);

void main() {
  const scenario = Scenario(id: 'test', title: 'Test scenario', description: 'Test description', level: 'A2', durationMinutes: 5);

  test('starts with a teacher opening message', () {
    final controller = createController()..start(scenario);
    expect(controller.state, isNotNull);
    expect(controller.state!.messages, hasLength(1));
    expect(controller.state!.messages.first.role, ConversationRole.teacher);
  });

  test('adds learner and teacher messages for each turn', () {
    final controller = createController()..start(scenario);
    controller.sendLearnerMessage('Hello');
    expect(controller.state!.learnerTurnCount, 1);
    expect(controller.state!.messages, hasLength(3));
    expect(controller.state!.messages[1].role, ConversationRole.learner);
    expect(controller.state!.messages[2].text, 'Teacher response 1');
  });

  test('stores detected corrections and teaching strategy', () {
    final controller = createController()..start(scenario);
    controller.sendLearnerMessage('I goed to school.');
    expect(controller.state!.corrections, hasLength(1));
    expect(controller.state!.corrections.first.correctedText, 'I went to school.');
    expect(controller.state!.teachingStrategy.useScaffolding, isTrue);
  });

  test('ignores empty learner messages', () {
    final controller = createController()..start(scenario);
    controller.sendLearnerMessage('   ');
    expect(controller.state!.learnerTurnCount, 0);
    expect(controller.state!.messages, hasLength(1));
  });
}

import 'package:flutter_test/flutter_test.dart';

import 'package:client/application/state/conversation_controller.dart';
import 'package:client/domain/entities/conversation_message.dart';
import 'package:client/domain/entities/scenario.dart';
import 'package:client/domain/services/conversation_engine.dart';

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

void main() {
  const scenario = Scenario(
    id: 'test',
    title: 'Test scenario',
    description: 'Test description',
    level: 'A2',
    durationMinutes: 5,
  );

  test('starts with a teacher opening message', () {
    final controller = ConversationController(
      engine: FakeConversationEngine(),
    );

    controller.start(scenario);

    expect(controller.state, isNotNull);
    expect(controller.state!.messages, hasLength(1));
    expect(controller.state!.messages.first.role, ConversationRole.teacher);
    expect(controller.state!.messages.first.text, 'Welcome.');
  });

  test('adds learner and teacher messages for each turn', () {
    final controller = ConversationController(
      engine: FakeConversationEngine(),
    );

    controller.start(scenario);
    controller.sendLearnerMessage('Hello');

    expect(controller.state!.learnerTurnCount, 1);
    expect(controller.state!.messages, hasLength(3));
    expect(controller.state!.messages[1].role, ConversationRole.learner);
    expect(controller.state!.messages[1].text, 'Hello');
    expect(controller.state!.messages[2].text, 'Teacher response 1');
  });

  test('ignores empty learner messages', () {
    final controller = ConversationController(
      engine: FakeConversationEngine(),
    );

    controller.start(scenario);
    controller.sendLearnerMessage('   ');

    expect(controller.state!.learnerTurnCount, 0);
    expect(controller.state!.messages, hasLength(1));
  });
}

import '../../domain/entities/conversation_message.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/services/conversation_engine.dart';

class DemoConversationEngine implements ConversationEngine {
  const DemoConversationEngine();

  @override
  ConversationMessage createOpeningMessage(Scenario scenario) {
    return ConversationMessage(
      role: ConversationRole.teacher,
      text: _openingFor(scenario),
    );
  }

  @override
  ConversationMessage respondToLearner({
    required Scenario scenario,
    required String learnerText,
    required int turnNumber,
  }) {
    final normalized = learnerText.trim().toLowerCase();

    if (normalized.isEmpty) {
      return const ConversationMessage(
        role: ConversationRole.teacher,
        text: 'Take your time. Try one short sentence.',
      );
    }

    if (normalized.contains('coffee') || normalized.contains('drink')) {
      return const ConversationMessage(
        role: ConversationRole.teacher,
        text: 'Nice! What size would you like?',
      );
    }

    if (normalized.contains('weekend') || normalized.contains('saturday')) {
      return const ConversationMessage(
        role: ConversationRole.teacher,
        text: 'Sounds good. Who will you spend the weekend with?',
      );
    }

    if (normalized.contains('work') || normalized.contains('school')) {
      return const ConversationMessage(
        role: ConversationRole.teacher,
        text: 'Good answer. What do you usually do there?',
      );
    }

    return const ConversationMessage(
      role: ConversationRole.teacher,
      text: 'Good job. Can you tell me a little more?',
    );
  }

  String _openingFor(Scenario scenario) {
    switch (scenario.id) {
      case 'coffee-shop':
        return 'Hi! Welcome to the coffee shop. What would you like to order?';
      case 'weekend-plans':
        return 'Hi! What are you going to do this weekend?';
      case 'daily-routine':
        return 'Hi! Tell me about your usual daily routine.';
      default:
        return 'Hi! Let\'s practice English together. Tell me about yourself.';
    }
  }
}

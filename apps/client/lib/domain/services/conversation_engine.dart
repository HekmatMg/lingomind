import '../entities/conversation_message.dart';
import '../entities/scenario.dart';

abstract interface class ConversationEngine {
  ConversationMessage createOpeningMessage(Scenario scenario);

  ConversationMessage respondToLearner({
    required Scenario scenario,
    required String learnerText,
    required int turnNumber,
  });
}

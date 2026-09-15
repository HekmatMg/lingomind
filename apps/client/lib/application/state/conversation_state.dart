import '../../domain/entities/conversation_message.dart';
import '../../domain/entities/scenario.dart';

class ConversationState {
  const ConversationState({
    required this.scenario,
    required this.messages,
    required this.learnerTurnCount,
    required this.isFinished,
  });

  final Scenario scenario;
  final List<ConversationMessage> messages;
  final int learnerTurnCount;
  final bool isFinished;

  ConversationState copyWith({
    List<ConversationMessage>? messages,
    int? learnerTurnCount,
    bool? isFinished,
  }) {
    return ConversationState(
      scenario: scenario,
      messages: messages ?? this.messages,
      learnerTurnCount: learnerTurnCount ?? this.learnerTurnCount,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}

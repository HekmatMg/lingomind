import '../../domain/entities/conversation_message.dart';
import '../../domain/entities/error_correction.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/services/teaching_brain.dart';

class ConversationState {
  const ConversationState({
    required this.scenario,
    required this.messages,
    required this.learnerTurnCount,
    required this.corrections,
    required this.isFinished,
    required this.teachingStrategy,
  });

  final Scenario scenario;
  final List<ConversationMessage> messages;
  final int learnerTurnCount;
  final List<ErrorCorrection> corrections;
  final bool isFinished;
  final TeachingStrategy teachingStrategy;

  ConversationState copyWith({
    List<ConversationMessage>? messages,
    int? learnerTurnCount,
    List<ErrorCorrection>? corrections,
    bool? isFinished,
    TeachingStrategy? teachingStrategy,
  }) {
    return ConversationState(
      scenario: scenario,
      messages: messages ?? this.messages,
      learnerTurnCount: learnerTurnCount ?? this.learnerTurnCount,
      corrections: corrections ?? this.corrections,
      isFinished: isFinished ?? this.isFinished,
      teachingStrategy: teachingStrategy ?? this.teachingStrategy,
    );
  }
}

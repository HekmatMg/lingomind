import '../../domain/entities/learner.dart';
import '../../domain/entities/learner_memory.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/services/learning_brain.dart';

class RecommendNextScenario {
  const RecommendNextScenario(this._brain);

  final LearningBrain _brain;

  Scenario execute({
    required Learner learner,
    required LearnerMemory memory,
    required List<Scenario> availableScenarios,
  }) {
    if (availableScenarios.isEmpty) {
      throw StateError('No scenarios are available for recommendation.');
    }
    return _brain.recommendNextScenario(
      learner: learner,
      memory: memory,
      availableScenarios: availableScenarios,
    );
  }
}

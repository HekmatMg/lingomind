import '../../domain/entities/learner.dart';
import '../../domain/entities/learner_memory.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/services/learning_brain.dart';

class DemoLearningBrain implements LearningBrain {
  const DemoLearningBrain();

  @override
  Scenario recommendNextScenario({
    required Learner learner,
    required LearnerMemory memory,
    required List<Scenario> availableScenarios,
  }) {
    if (availableScenarios.isEmpty) {
      throw StateError('No scenarios are available.');
    }

    final matchingLevel = availableScenarios.where(
      (scenario) => scenario.level == learner.level,
    );
    final pool = matchingLevel.isEmpty
        ? availableScenarios
        : matchingLevel.toList();

    if (memory.repeatedErrors.isNotEmpty) {
      return pool.first;
    }

    return pool.first;
  }
}

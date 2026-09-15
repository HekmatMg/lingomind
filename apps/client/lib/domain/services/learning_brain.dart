import '../entities/learner.dart';
import '../entities/learner_memory.dart';
import '../entities/scenario.dart';

abstract interface class LearningBrain {
  Scenario recommendNextScenario({
    required Learner learner,
    required LearnerMemory memory,
    required List<Scenario> availableScenarios,
  });
}

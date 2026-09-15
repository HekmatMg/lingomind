import '../entities/learner_memory.dart';

abstract interface class LearnerMemoryRepository {
  LearnerMemory load();

  void save(LearnerMemory memory);
}

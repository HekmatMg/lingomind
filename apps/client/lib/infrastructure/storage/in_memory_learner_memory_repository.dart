import '../../domain/entities/learner_memory.dart';
import '../../domain/repositories/learner_memory_repository.dart';

class InMemoryLearnerMemoryRepository implements LearnerMemoryRepository {
  LearnerMemory _memory = LearnerMemory.empty();

  @override
  LearnerMemory load() => _memory;

  @override
  void save(LearnerMemory memory) {
    _memory = memory;
  }
}

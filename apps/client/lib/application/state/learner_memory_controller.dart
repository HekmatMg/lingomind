import '../../domain/entities/error_correction.dart';
import '../../domain/entities/learner_memory.dart';
import '../../domain/repositories/learner_memory_repository.dart';

class LearnerMemoryController {
  LearnerMemoryController({required LearnerMemoryRepository repository})
      : _repository = repository,
        _memory = repository.load();

  final LearnerMemoryRepository _repository;
  LearnerMemory _memory;

  LearnerMemory get memory => _memory;

  void recordCorrection(ErrorCorrection correction) {
    final error = correction.originalText;
    if (error.trim().isEmpty || _memory.repeatedErrors.contains(error)) return;

    _memory = _memory.copyWith(
      repeatedErrors: [..._memory.repeatedErrors, error],
    );
    _repository.save(_memory);
  }

  void addVocabularyTarget(String word) {
    final normalized = word.trim().toLowerCase();
    if (normalized.isEmpty || _memory.vocabularyTargets.contains(normalized)) {
      return;
    }

    _memory = _memory.copyWith(
      vocabularyTargets: [..._memory.vocabularyTargets, normalized],
    );
    _repository.save(_memory);
  }
}

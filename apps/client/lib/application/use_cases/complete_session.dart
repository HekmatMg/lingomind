import '../../domain/entities/error_correction.dart';
import '../../domain/entities/session_result.dart';
import '../../domain/repositories/learner_memory_repository.dart';
import '../../domain/repositories/progress_repository.dart';

class CompleteSession {
  const CompleteSession({
    required ProgressRepository progressRepository,
    required LearnerMemoryRepository memoryRepository,
  })  : _progressRepository = progressRepository,
        _memoryRepository = memoryRepository;

  final ProgressRepository _progressRepository;
  final LearnerMemoryRepository _memoryRepository;

  void execute({
    required SessionResult result,
    required List<ErrorCorrection> corrections,
  }) {
    _progressRepository.recordSession(result);

    final memory = _memoryRepository.load();
    var next = memory;
    for (final correction in corrections) {
      if (!next.repeatedErrors.contains(correction.originalText)) {
        next = next.copyWith(
          repeatedErrors: [...next.repeatedErrors, correction.originalText],
        );
      }
    }
    _memoryRepository.save(next);
  }
}

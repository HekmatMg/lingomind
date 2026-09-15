import '../../domain/entities/session_result.dart';
import '../../domain/repositories/progress_repository.dart';
import 'progress_state.dart';

class ProgressController {
  ProgressController({required ProgressRepository repository})
      : _repository = repository,
        _state = repository.load();

  final ProgressRepository _repository;
  ProgressState _state;

  ProgressState get state => _state;

  void recordSession(SessionResult result) {
    _repository.recordSession(result);
    _state = _state.addSession(result);
  }
}

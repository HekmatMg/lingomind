import '../../application/state/progress_state.dart';
import '../../domain/entities/session_result.dart';
import '../../domain/repositories/progress_repository.dart';

class InMemoryProgressRepository implements ProgressRepository {
  ProgressState _state = ProgressState.demo();

  @override
  ProgressState load() => _state;

  @override
  void recordSession(SessionResult result) {
    _state = _state.addSession(result);
  }
}

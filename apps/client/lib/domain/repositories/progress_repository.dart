import '../../application/state/progress_state.dart';
import '../entities/session_result.dart';

abstract interface class ProgressRepository {
  ProgressState load();

  void recordSession(SessionResult result);
}

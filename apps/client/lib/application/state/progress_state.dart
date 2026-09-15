import '../../domain/entities/session_result.dart';

class ProgressState {
  const ProgressState({required this.sessions});

  final List<SessionResult> sessions;

  int get completedSessions =>
      sessions.where((session) => session.completed).length;

  int get totalTurns =>
      sessions.fold(0, (sum, session) => sum + session.turnCount);

  int get totalCorrections =>
      sessions.fold(0, (sum, session) => sum + session.correctionCount);

  ProgressState addSession(SessionResult result) {
    return ProgressState(sessions: [...sessions, result]);
  }

  static ProgressState demo() {
    return const ProgressState(sessions: []);
  }
}

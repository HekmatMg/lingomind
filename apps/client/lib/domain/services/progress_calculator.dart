import '../entities/progress_summary.dart';
import '../entities/session_result.dart';

class ProgressCalculator {
  const ProgressCalculator();

  ProgressSummary summarize(List<SessionResult> sessions) {
    final completed = sessions.where((session) => session.completed).length;
    final turns = sessions.fold<int>(
      0,
      (sum, session) => sum + session.turnCount,
    );
    final corrections = sessions.fold<int>(
      0,
      (sum, session) => sum + session.correctionCount,
    );

    return ProgressSummary(
      completedSessions: completed,
      totalTurns: turns,
      totalCorrections: corrections,
    );
  }
}

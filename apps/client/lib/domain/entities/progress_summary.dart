class ProgressSummary {
  const ProgressSummary({
    required this.completedSessions,
    required this.totalTurns,
    required this.totalCorrections,
  });

  final int completedSessions;
  final int totalTurns;
  final int totalCorrections;

  double get correctionRate {
    if (totalTurns == 0) return 0;
    return totalCorrections / totalTurns;
  }
}

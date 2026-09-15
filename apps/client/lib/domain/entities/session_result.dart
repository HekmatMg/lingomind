class SessionResult {
  const SessionResult({
    required this.scenarioId,
    required this.turnCount,
    required this.correctionCount,
    required this.completed,
  });

  final String scenarioId;
  final int turnCount;
  final int correctionCount;
  final bool completed;

  double get correctionRate {
    if (turnCount == 0) return 0;
    return correctionCount / turnCount;
  }
}

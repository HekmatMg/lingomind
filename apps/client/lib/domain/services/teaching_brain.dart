enum CorrectionTiming { immediate, afterTurn, endOfSession }

enum TeachingQuestionStyle { open, guided, choice }

class TeachingStrategy {
  const TeachingStrategy({
    required this.correctionTiming,
    required this.questionStyle,
    required this.useScaffolding,
  });

  final CorrectionTiming correctionTiming;
  final TeachingQuestionStyle questionStyle;
  final bool useScaffolding;
}

abstract interface class TeachingBrain {
  TeachingStrategy strategyFor({
    required String learnerLevel,
    required int recentCorrectionCount,
  });
}

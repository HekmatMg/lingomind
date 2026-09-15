import '../../domain/services/teaching_brain.dart';

class DemoTeachingBrain implements TeachingBrain {
  const DemoTeachingBrain();

  @override
  TeachingStrategy strategyFor({
    required String learnerLevel,
    required int recentCorrectionCount,
  }) {
    if (recentCorrectionCount >= 3) {
      return const TeachingStrategy(
        correctionTiming: CorrectionTiming.afterTurn,
        questionStyle: TeachingQuestionStyle.guided,
        useScaffolding: true,
      );
    }

    return TeachingStrategy(
      correctionTiming: learnerLevel == 'A1'
          ? CorrectionTiming.immediate
          : CorrectionTiming.afterTurn,
      questionStyle: TeachingQuestionStyle.open,
      useScaffolding: learnerLevel == 'A1',
    );
  }
}

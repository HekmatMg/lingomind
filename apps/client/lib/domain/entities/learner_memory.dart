class LearnerMemory {
  const LearnerMemory({
    required this.repeatedErrors,
    required this.vocabularyTargets,
    required this.interests,
    required this.goals,
  });

  final List<String> repeatedErrors;
  final List<String> vocabularyTargets;
  final List<String> interests;
  final List<String> goals;

  LearnerMemory copyWith({
    List<String>? repeatedErrors,
    List<String>? vocabularyTargets,
    List<String>? interests,
    List<String>? goals,
  }) {
    return LearnerMemory(
      repeatedErrors: repeatedErrors ?? this.repeatedErrors,
      vocabularyTargets: vocabularyTargets ?? this.vocabularyTargets,
      interests: interests ?? this.interests,
      goals: goals ?? this.goals,
    );
  }

  static LearnerMemory empty() {
    return const LearnerMemory(
      repeatedErrors: [],
      vocabularyTargets: [],
      interests: [],
      goals: [],
    );
  }
}

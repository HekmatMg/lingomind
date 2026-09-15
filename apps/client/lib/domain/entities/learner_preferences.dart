class LearnerPreferences {
  const LearnerPreferences({
    required this.nativeLanguage,
    required this.targetLanguage,
    required this.interests,
    required this.goals,
    required this.correctionLanguage,
  });

  final String nativeLanguage;
  final String targetLanguage;
  final List<String> interests;
  final List<String> goals;
  final String correctionLanguage;

  LearnerPreferences copyWith({
    String? nativeLanguage,
    String? targetLanguage,
    List<String>? interests,
    List<String>? goals,
    String? correctionLanguage,
  }) {
    return LearnerPreferences(
      nativeLanguage: nativeLanguage ?? this.nativeLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      interests: interests ?? this.interests,
      goals: goals ?? this.goals,
      correctionLanguage: correctionLanguage ?? this.correctionLanguage,
    );
  }

  static const demo = LearnerPreferences(
    nativeLanguage: 'Persian',
    targetLanguage: 'English',
    interests: ['Technology', 'Travel', 'Daily life'],
    goals: ['Speaking fluency', 'Vocabulary', 'Grammar'],
    correctionLanguage: 'Persian',
  );
}

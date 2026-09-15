import '../entities/learner_preferences.dart';

abstract interface class LearnerPreferencesRepository {
  LearnerPreferences load();
  void save(LearnerPreferences preferences);
}

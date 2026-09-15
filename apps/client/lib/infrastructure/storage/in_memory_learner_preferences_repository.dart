import '../../domain/entities/learner_preferences.dart';
import '../../domain/repositories/learner_preferences_repository.dart';

class InMemoryLearnerPreferencesRepository
    implements LearnerPreferencesRepository {
  LearnerPreferences _preferences = LearnerPreferences.demo;

  @override
  LearnerPreferences load() => _preferences;

  @override
  void save(LearnerPreferences preferences) {
    _preferences = preferences;
  }
}

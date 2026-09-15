import '../../domain/entities/learner.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/entities/learner_preferences.dart';

class AppState {
  const AppState({
    required this.learner,
    required this.preferences,
    required this.recommendedScenarios,
    required this.featuredScenario,
  });

  final Learner learner;
  final LearnerPreferences preferences;
  final List<Scenario> recommendedScenarios;
  final Scenario featuredScenario;

  factory AppState.demo({Scenario? featuredScenario}) {
    const scenarios = [
      Scenario(
        id: 'coffee-shop',
        title: 'At the Coffee Shop',
        description: 'Practice ordering a drink and making a simple request.',
        level: 'A2',
        durationMinutes: 10,
      ),
      Scenario(
        id: 'weekend-plans',
        title: 'Weekend Plans',
        description: 'Talk about your plans, preferences, and free time.',
        level: 'A2',
        durationMinutes: 12,
      ),
      Scenario(
        id: 'daily-routine',
        title: 'My Daily Routine',
        description: 'Describe your routine and practice everyday vocabulary.',
        level: 'A2',
        durationMinutes: 8,
      ),
    ];

    return AppState(
      learner: const Learner(
        name: 'Learner',
        level: 'A2',
        dailyGoalMinutes: 15,
        currentStreak: 3,
      ),
      preferences: LearnerPreferences.demo,
      recommendedScenarios: scenarios,
      featuredScenario: featuredScenario ?? scenarios.first,
    );
  }
}

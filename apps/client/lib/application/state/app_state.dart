import '../../domain/entities/learner.dart';
import '../../domain/entities/scenario.dart';

class AppState {
  const AppState({
    required this.learner,
    required this.recommendedScenarios,
  });

  final Learner learner;
  final List<Scenario> recommendedScenarios;

  factory AppState.demo() {
    return const AppState(
      learner: Learner(
        name: 'Learner',
        level: 'A2',
        dailyGoalMinutes: 15,
        currentStreak: 3,
      ),
      recommendedScenarios: [
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
      ],
    );
  }
}

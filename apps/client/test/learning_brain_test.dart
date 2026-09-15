import 'package:flutter_test/flutter_test.dart';

import 'package:client/domain/entities/learner.dart';
import 'package:client/domain/entities/learner_memory.dart';
import 'package:client/domain/entities/scenario.dart';
import 'package:client/infrastructure/ai/demo_learning_brain.dart';

void main() {
  const learner = Learner(
    name: 'Test',
    level: 'A2',
    dailyGoalMinutes: 15,
    currentStreak: 0,
  );

  const scenarios = [
    Scenario(
      id: 'a1',
      title: 'Beginner',
      description: 'A1 scenario',
      level: 'A1',
      durationMinutes: 5,
    ),
    Scenario(
      id: 'a2',
      title: 'Intermediate',
      description: 'A2 scenario',
      level: 'A2',
      durationMinutes: 5,
    ),
  ];

  test('prefers a scenario matching learner level', () {
    final brain = DemoLearningBrain();

    final result = brain.recommendNextScenario(
      learner: learner,
      memory: LearnerMemory.empty(),
      availableScenarios: scenarios,
    );

    expect(result.id, 'a2');
  });
}

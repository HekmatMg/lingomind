class Learner {
  const Learner({
    required this.name,
    required this.level,
    required this.dailyGoalMinutes,
    required this.currentStreak,
  });

  final String name;
  final String level;
  final int dailyGoalMinutes;
  final int currentStreak;
}

class Scenario {
  const Scenario({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.durationMinutes,
  });

  final String id;
  final String title;
  final String description;
  final String level;
  final int durationMinutes;
}

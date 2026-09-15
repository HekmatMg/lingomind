import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/learner_memory.dart';
import '../../domain/repositories/learner_memory_repository.dart';

class SharedPreferencesLearnerMemoryRepository
    implements LearnerMemoryRepository {
  SharedPreferencesLearnerMemoryRepository(this._preferences);

  static const _key = 'learner_memory_v1';
  final SharedPreferences _preferences;

  @override
  LearnerMemory load() {
    final raw = _preferences.getString(_key);
    if (raw == null || raw.isEmpty) return LearnerMemory.empty();

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return LearnerMemory.empty();
      return LearnerMemory(
        repeatedErrors: _strings(decoded['repeatedErrors']),
        vocabularyTargets: _strings(decoded['vocabularyTargets']),
        interests: _strings(decoded['interests']),
        goals: _strings(decoded['goals']),
      );
    } on FormatException {
      return LearnerMemory.empty();
    }
  }

  @override
  void save(LearnerMemory memory) {
    final payload = jsonEncode({
      'repeatedErrors': memory.repeatedErrors,
      'vocabularyTargets': memory.vocabularyTargets,
      'interests': memory.interests,
      'goals': memory.goals,
    });
    _preferences.setString(_key, payload);
  }

  List<String> _strings(Object? value) {
    if (value is! List) return const [];
    return value.whereType<String>().toList(growable: false);
  }
}

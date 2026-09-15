import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../application/state/progress_state.dart';
import '../../domain/entities/session_result.dart';
import '../../domain/repositories/progress_repository.dart';

class SharedPreferencesProgressRepository implements ProgressRepository {
  SharedPreferencesProgressRepository(this._preferences);

  static const _key = 'progress_state_v1';
  final SharedPreferences _preferences;

  @override
  ProgressState load() {
    final raw = _preferences.getString(_key);
    if (raw == null || raw.isEmpty) return ProgressState.demo();

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return ProgressState.demo();
      final sessions = decoded
          .whereType<Map>()
          .map(_sessionFromJson)
          .whereType<SessionResult>()
          .toList(growable: false);
      return ProgressState(sessions: sessions);
    } on FormatException {
      return ProgressState.demo();
    }
  }

  @override
  void recordSession(SessionResult result) {
    final current = load();
    final sessions = [
      ...current.sessions,
      result,
    ];
    _preferences.setString(
      _key,
      jsonEncode(sessions.map(_sessionToJson).toList()),
    );
  }

  Map<String, Object> _sessionToJson(SessionResult session) => {
        'scenarioId': session.scenarioId,
        'turnCount': session.turnCount,
        'correctionCount': session.correctionCount,
        'completed': session.completed,
      };

  SessionResult? _sessionFromJson(Map value) {
    final scenarioId = value['scenarioId'];
    final turnCount = value['turnCount'];
    final correctionCount = value['correctionCount'];
    final completed = value['completed'];
    if (scenarioId is! String ||
        turnCount is! num ||
        correctionCount is! num ||
        completed is! bool) {
      return null;
    }
    if (turnCount < 0 || correctionCount < 0) return null;
    return SessionResult(
      scenarioId: scenarioId,
      turnCount: turnCount.toInt(),
      correctionCount: correctionCount.toInt(),
      completed: completed,
    );
  }
}

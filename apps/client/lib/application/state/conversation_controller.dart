import 'package:flutter/foundation.dart';

import '../../domain/entities/conversation_message.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/entities/session_result.dart';
import '../../domain/services/conversation_engine.dart';
import '../../domain/services/error_detector.dart';
import 'conversation_state.dart';

class ConversationController extends ChangeNotifier {
  ConversationController({
    required ConversationEngine engine,
    required ErrorDetector errorDetector,
  })  : _engine = engine,
        _errorDetector = errorDetector;

  final ConversationEngine _engine;
  final ErrorDetector _errorDetector;
  ConversationState? _state;

  ConversationState? get state => _state;

  SessionResult? get sessionResult {
    final current = _state;
    if (current == null) return null;

    return SessionResult(
      scenarioId: current.scenario.id,
      turnCount: current.learnerTurnCount,
      correctionCount: current.corrections.length,
      completed: current.isFinished,
    );
  }

  void start(Scenario scenario) {
    final opening = _engine.createOpeningMessage(scenario);
    _state = ConversationState(
      scenario: scenario,
      messages: [opening],
      learnerTurnCount: 0,
      corrections: const [],
      isFinished: false,
    );
    notifyListeners();
  }

  void sendLearnerMessage(String text) {
    final current = _state;
    final normalized = text.trim();
    if (current == null || current.isFinished || normalized.isEmpty) return;

    final learnerMessage = ConversationMessage(
      role: ConversationRole.learner,
      text: normalized,
    );
    final nextTurn = current.learnerTurnCount + 1;
    final teacherMessage = _engine.respondToLearner(
      scenario: current.scenario,
      learnerText: normalized,
      turnNumber: nextTurn,
    );
    final correction = _errorDetector.detect(normalized);

    _state = current.copyWith(
      messages: [
        ...current.messages,
        learnerMessage,
        teacherMessage,
      ],
      learnerTurnCount: nextTurn,
      corrections: correction == null
          ? current.corrections
          : [...current.corrections, correction],
    );
    notifyListeners();
  }

  void finish() {
    final current = _state;
    if (current == null || current.isFinished) return;

    _state = current.copyWith(isFinished: true);
    notifyListeners();
  }
}

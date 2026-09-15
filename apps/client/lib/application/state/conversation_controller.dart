import 'package:flutter/foundation.dart';

import '../../domain/entities/conversation_message.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/entities/session_result.dart';
import '../../domain/services/conversation_engine.dart';
import '../../domain/services/error_detector.dart';
import '../../domain/services/teaching_brain.dart';
import 'conversation_state.dart';

class ConversationController extends ChangeNotifier {
  ConversationController({
    required ConversationEngine engine,
    required ErrorDetector errorDetector,
    required TeachingBrain teachingBrain,
    required String learnerLevel,
  })  : _engine = engine,
        _errorDetector = errorDetector,
        _teachingBrain = teachingBrain,
        _learnerLevel = learnerLevel;

  final ConversationEngine _engine;
  final ErrorDetector _errorDetector;
  final TeachingBrain _teachingBrain;
  final String _learnerLevel;
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
    final strategy = _teachingBrain.strategyFor(
      learnerLevel: _learnerLevel,
      recentCorrectionCount: 0,
    );
    _state = ConversationState(
      scenario: scenario,
      messages: [opening],
      learnerTurnCount: 0,
      corrections: const [],
      isFinished: false,
      teachingStrategy: strategy,
    );
    notifyListeners();
  }

  void sendLearnerMessage(String text) {
    final current = _state;
    final normalized = text.trim();
    if (current == null || current.isFinished || normalized.isEmpty) return;

    final nextTurn = current.learnerTurnCount + 1;
    final correction = _errorDetector.detect(normalized);
    final totalCorrections = current.corrections.length + (correction == null ? 0 : 1);
    final strategy = _teachingBrain.strategyFor(
      learnerLevel: _learnerLevel,
      recentCorrectionCount: totalCorrections,
    );
    final learnerMessage = ConversationMessage(
      role: ConversationRole.learner,
      text: normalized,
    );
    final teacherMessage = _engine.respondToLearner(
      scenario: current.scenario,
      learnerText: normalized,
      turnNumber: nextTurn,
    );

    _state = current.copyWith(
      messages: [...current.messages, learnerMessage, teacherMessage],
      learnerTurnCount: nextTurn,
      corrections: correction == null
          ? current.corrections
          : [...current.corrections, correction],
      teachingStrategy: strategy,
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

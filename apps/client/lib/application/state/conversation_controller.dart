import 'package:flutter/foundation.dart';

import '../../domain/entities/conversation_message.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/services/conversation_engine.dart';
import 'conversation_state.dart';

class ConversationController extends ChangeNotifier {
  ConversationController({required ConversationEngine engine}) : _engine = engine;

  final ConversationEngine _engine;
  ConversationState? _state;

  ConversationState? get state => _state;

  void start(Scenario scenario) {
    final opening = _engine.createOpeningMessage(scenario);
    _state = ConversationState(
      scenario: scenario,
      messages: [opening],
      learnerTurnCount: 0,
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

    _state = current.copyWith(
      messages: [
        ...current.messages,
        learnerMessage,
        teacherMessage,
      ],
      learnerTurnCount: nextTurn,
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

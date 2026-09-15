import 'package:flutter/material.dart';

import '../../application/state/conversation_controller.dart';
import '../../domain/entities/conversation_message.dart';
import '../../domain/entities/error_correction.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/services/conversation_engine.dart';
import '../../domain/services/error_detector.dart';
import 'session_summary_screen.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    super.key,
    required this.scenario,
    required this.engine,
    required this.errorDetector,
  });

  final Scenario scenario;
  final ConversationEngine engine;
  final ErrorDetector errorDetector;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late final ConversationController _controller;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = ConversationController(
      engine: widget.engine,
      errorDetector: widget.errorDetector,
    )..start(widget.scenario);
    _controller.addListener(_onConversationChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onConversationChanged)
      ..dispose();
    _textController.dispose();
    super.dispose();
  }

  void _onConversationChanged() {
    if (mounted) setState(() {});
  }

  void _sendMessage() {
    final text = _textController.text;
    if (text.trim().isEmpty) return;
    _controller.sendLearnerMessage(text);
    _textController.clear();
  }

  void _finishSession() {
    _controller.finish();
    final result = _controller.sessionResult;
    if (result == null) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => SessionSummaryScreen(
          scenario: widget.scenario,
          result: result,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.state!;

    return Scaffold(
      appBar: AppBar(title: Text(widget.scenario.title)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.messages.length,
              itemBuilder: (context, index) => _MessageBubble(message: state.messages[index]),
            ),
          ),
          if (state.corrections.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: _CorrectionCard(correction: state.corrections.last),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: const InputDecoration(
                        hintText: 'Type your answer...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(onPressed: _sendMessage, icon: const Icon(Icons.send), tooltip: 'Send'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(onPressed: _finishSession, child: const Text('Finish session')),
            ),
          ),
        ],
      ),
    );
  }
}

class _CorrectionCard extends StatelessWidget {
  const _CorrectionCard({required this.correction});

  final ErrorCorrection correction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Correction', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(correction.explanation),
            const SizedBox(height: 4),
            Text(correction.correctedText, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ConversationMessage message;

  @override
  Widget build(BuildContext context) {
    final isLearner = message.role == ConversationRole.learner;

    return Align(
      alignment: isLearner ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: isLearner
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(message.text),
      ),
    );
  }
}

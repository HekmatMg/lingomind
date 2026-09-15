import 'package:flutter/material.dart';

import '../../application/state/conversation_controller.dart';
import '../../domain/entities/conversation_message.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/services/conversation_engine.dart';
import 'session_summary_screen.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    super.key,
    required this.scenario,
    required this.engine,
  });

  final Scenario scenario;
  final ConversationEngine engine;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late final ConversationController _controller;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = ConversationController(engine: widget.engine)..start(widget.scenario);
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => SessionSummaryScreen(scenario: widget.scenario),
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
              itemBuilder: (context, index) =>
                  _MessageBubble(message: state.messages[index]),
            ),
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
                  IconButton.filled(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                    tooltip: 'Send',
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _finishSession,
                child: const Text('Finish session'),
              ),
            ),
          ),
        ],
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

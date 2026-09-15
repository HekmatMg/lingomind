import 'package:flutter/material.dart';

import 'application/state/app_state.dart';
import 'domain/services/conversation_engine.dart';
import 'infrastructure/ai/demo_conversation_engine.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const LingoMindApp());
}

class LingoMindApp extends StatelessWidget {
  const LingoMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.demo();
    final ConversationEngine conversationEngine =
        const DemoConversationEngine();

    return MaterialApp(
      title: 'LingoMind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: HomeScreen(
        state: appState,
        engine: conversationEngine,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'application/state/app_state.dart';
import 'application/use_cases/complete_session.dart';
import 'application/use_cases/recommend_next_scenario.dart';
import 'domain/repositories/learner_memory_repository.dart';
import 'domain/repositories/progress_repository.dart';
import 'domain/services/conversation_engine.dart';
import 'domain/services/error_detector.dart';
import 'domain/services/learning_brain.dart';
import 'domain/services/teaching_brain.dart';
import 'infrastructure/ai/demo_conversation_engine.dart';
import 'infrastructure/ai/demo_error_detector.dart';
import 'infrastructure/ai/demo_learning_brain.dart';
import 'infrastructure/ai/demo_teaching_brain.dart';
import 'infrastructure/storage/in_memory_learner_memory_repository.dart';
import 'infrastructure/storage/in_memory_progress_repository.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const LingoMindApp());
}

class LingoMindApp extends StatelessWidget {
  const LingoMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.demo();
    final ConversationEngine conversationEngine = const DemoConversationEngine();
    final ErrorDetector errorDetector = const DemoErrorDetector();
    final LearningBrain learningBrain = const DemoLearningBrain();
    final TeachingBrain teachingBrain = const DemoTeachingBrain();
    final LearnerMemoryRepository memoryRepository = InMemoryLearnerMemoryRepository();
    final ProgressRepository progressRepository = InMemoryProgressRepository();
    final recommended = RecommendNextScenario(learningBrain).execute(
      learner: appState.learner,
      memory: memoryRepository.load(),
      availableScenarios: appState.recommendedScenarios,
    );
    final completeSession = CompleteSession(
      progressRepository: progressRepository,
      memoryRepository: memoryRepository,
    );
    final configuredState = AppState.demo(featuredScenario: recommended);

    return MaterialApp(
      title: 'LingoMind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: HomeScreen(
        state: configuredState,
        engine: conversationEngine,
        errorDetector: errorDetector,
        teachingBrain: teachingBrain,
        completeSession: completeSession,
      ),
    );
  }
}

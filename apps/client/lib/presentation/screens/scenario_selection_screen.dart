import 'package:flutter/material.dart';

import '../../application/state/app_state.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/services/conversation_engine.dart';
import '../../domain/services/error_detector.dart';
import 'conversation_screen.dart';

class ScenarioSelectionScreen extends StatelessWidget {
  const ScenarioSelectionScreen({
    super.key,
    required this.state,
    required this.engine,
    required this.errorDetector,
  });

  final AppState state;
  final ConversationEngine engine;
  final ErrorDetector errorDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a scenario')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: state.recommendedScenarios.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final scenario = state.recommendedScenarios[index];
          return _ScenarioCard(
            scenario: scenario,
            engine: engine,
            errorDetector: errorDetector,
          );
        },
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  const _ScenarioCard({
    required this.scenario,
    required this.engine,
    required this.errorDetector,
  });

  final Scenario scenario;
  final ConversationEngine engine;
  final ErrorDetector errorDetector;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(scenario.title, style: Theme.of(context).textTheme.titleLarge)),
            Chip(label: Text(scenario.level)),
          ]),
          const SizedBox(height: 8),
          Text(scenario.description),
          const SizedBox(height: 12),
          Row(children: [
            const Icon(Icons.timer_outlined, size: 18),
            const SizedBox(width: 6),
            Text('${scenario.durationMinutes} min'),
            const Spacer(),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ConversationScreen(
                    scenario: scenario,
                    engine: engine,
                    errorDetector: errorDetector,
                  ),
                ));
              },
              child: const Text('Start'),
            ),
          ]),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../application/state/app_state.dart';
import '../../application/use_cases/complete_session.dart';
import '../../domain/services/conversation_engine.dart';
import '../../domain/services/error_detector.dart';
import '../../domain/services/teaching_brain.dart';
import 'scenario_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.state, required this.engine, required this.errorDetector, required this.teachingBrain, required this.completeSession});
  final AppState state;
  final ConversationEngine engine;
  final ErrorDetector errorDetector;
  final TeachingBrain teachingBrain;
  final CompleteSession completeSession;

  void _openScenarios(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ScenarioSelectionScreen(
      state: state, engine: engine, errorDetector: errorDetector, teachingBrain: teachingBrain, completeSession: completeSession,
    )));
  }

  @override
  Widget build(BuildContext context) {
    final learner = state.learner;
    final featuredScenario = state.featuredScenario;
    return Scaffold(
      appBar: AppBar(title: const Text('LingoMind'), actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline), tooltip: 'Profile')]),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text('Welcome back, ${learner.name}', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 6), const Text('Ready for a little English practice?'), const SizedBox(height: 20),
        Row(children: [
          Expanded(child: _StatCard(icon: Icons.school_outlined, label: 'Level', value: learner.level)), const SizedBox(width: 12),
          Expanded(child: _StatCard(icon: Icons.local_fire_department_outlined, label: 'Streak', value: '${learner.currentStreak} days')),
        ]),
        const SizedBox(height: 24), Text("Today's recommendation", style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 10),
        Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(featuredScenario.title, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 8), Text(featuredScenario.description), const SizedBox(height: 14),
          Row(children: [const Icon(Icons.timer_outlined, size: 18), const SizedBox(width: 6), Text('${featuredScenario.durationMinutes} min'), const Spacer(), FilledButton(onPressed: () => _openScenarios(context), child: const Text('Practice'))]),
        ]))),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: Text('Recommended for you', style: Theme.of(context).textTheme.titleLarge)), TextButton(onPressed: () => _openScenarios(context), child: const Text('See all'))]),
        ...state.recommendedScenarios.where((s) => s.id != featuredScenario.id).map((scenario) => ListTile(
          contentPadding: EdgeInsets.zero, leading: const CircleAvatar(child: Icon(Icons.chat_bubble_outline)), title: Text(scenario.title), subtitle: Text('${scenario.level} • ${scenario.durationMinutes} min'), onTap: () => _openScenarios(context),
        )),
      ]),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.label, required this.value});
  final IconData icon; final String label; final String value;
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon), const SizedBox(height: 10), Text(label), const SizedBox(height: 2), Text(value, style: Theme.of(context).textTheme.titleMedium)])));
}

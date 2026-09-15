import 'package:flutter/material.dart';

import '../../application/state/progress_state.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key, required this.progress});

  final ProgressState progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Your learning progress', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _MetricCard(label: 'Sessions', value: '${progress.completedSessions}')),
              const SizedBox(width: 12),
              Expanded(child: _MetricCard(label: 'Turns', value: '${progress.totalTurns}')),
            ],
          ),
          const SizedBox(height: 12),
          _MetricCard(label: 'Corrections reviewed', value: '${progress.totalCorrections}'),
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Progress will become personalized as LingoMind collects learning signals from your sessions.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter_test/flutter_test.dart';

import 'package:client/application/state/learner_memory_controller.dart';
import 'package:client/domain/entities/error_correction.dart';
import 'package:client/infrastructure/storage/in_memory_learner_memory_repository.dart';

void main() {
  test('records a correction in learner memory', () {
    final repository = InMemoryLearnerMemoryRepository();
    final controller = LearnerMemoryController(repository: repository);

    controller.recordCorrection(
      const ErrorCorrection(
        originalText: 'I goed to school.',
        explanation: 'Use went.',
        correctedText: 'I went to school.',
      ),
    );

    expect(controller.memory.repeatedErrors, ['I goed to school.']);
    expect(repository.load().repeatedErrors, ['I goed to school.']);
  });

  test('does not duplicate a correction or vocabulary target', () {
    final controller = LearnerMemoryController(
      repository: InMemoryLearnerMemoryRepository(),
    );

    const correction = ErrorCorrection(
      originalText: 'I goed to school.',
      explanation: 'Use went.',
      correctedText: 'I went to school.',
    );

    controller.recordCorrection(correction);
    controller.recordCorrection(correction);
    controller.addVocabularyTarget('Use');
    controller.addVocabularyTarget(' use ');

    expect(controller.memory.repeatedErrors, hasLength(1));
    expect(controller.memory.vocabularyTargets, ['use']);
  });
}

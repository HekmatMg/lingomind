import 'package:client/domain/entities/session_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('calculates correction rate', () {
    const result = SessionResult(
      scenarioId: 'coffee-shop',
      turnCount: 4,
      correctionCount: 1,
      completed: true,
    );

    expect(result.correctionRate, 0.25);
  });

  test('returns zero correction rate when there are no turns', () {
    const result = SessionResult(
      scenarioId: 'coffee-shop',
      turnCount: 0,
      correctionCount: 0,
      completed: true,
    );

    expect(result.correctionRate, 0);
  });
}

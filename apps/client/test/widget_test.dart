import 'package:client/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LingoMind home loads learner context', (WidgetTester tester) async {
    await tester.pumpWidget(const LingoMindApp());

    expect(find.text('LingoMind'), findsOneWidget);
    expect(find.text('Welcome back, Learner'), findsOneWidget);
    expect(find.text('A2'), findsOneWidget);
    expect(find.text('3 days'), findsOneWidget);
    expect(find.text('Today\'s recommendation'), findsOneWidget);
    expect(find.text('At the Coffee Shop'), findsOneWidget);
  });
}

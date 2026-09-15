import 'package:client/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('LingoMind home loads learner context', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(LingoMindApp(preferences: preferences));

    expect(find.text('LingoMind'), findsOneWidget);
    expect(find.text('Welcome back, Learner'), findsOneWidget);
    expect(find.text('A2'), findsOneWidget);
    expect(find.text('3 days'), findsOneWidget);
    expect(find.text("Today's recommendation"), findsOneWidget);
    expect(find.text('At the Coffee Shop'), findsOneWidget);
  });
}

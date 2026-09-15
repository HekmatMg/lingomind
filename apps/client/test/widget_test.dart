import 'package:flutter_test/flutter_test.dart';

import 'package:client/main.dart';

void main() {
  testWidgets('LingoMind app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const LingoMindApp());

    expect(find.text('LingoMind'), findsOneWidget);
    expect(find.text('Welcome to LingoMind'), findsOneWidget);
  });
}
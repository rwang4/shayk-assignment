// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shayk_assignment/main.dart';

void main() {
  testWidgets('Buttons smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MyApp(),
    );
    // Tap the display button and trigger a dialog
    expect(find.byType(ElevatedButton), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    // Check Dialog
    expect(find.byType(Dialog), findsOneWidget);
    // Check ScrollView
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    // Check Agree Button
    expect(find.text("No"), findsOneWidget);
    // Tap the close button to close the dialog
    expect(find.byIcon(Icons.close), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}

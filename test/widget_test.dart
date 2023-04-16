// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wave_hand/main.dart';

void main() {

  late Widget parent;

  setUp(() {
    parent = const MaterialApp(home: MyApp(),);
  });

  testWidgets('find bottom text', (tester) async {
    final infoText = find.descendant(of: find.byType(Padding), matching: find.text('Tap to wave'));

    await tester.pumpWidget(parent);
    
    expect(infoText, findsOneWidget);

  });

  testWidgets('find wave hand emoji', (tester) async {
      final waveEmoji = find.byKey(const Key('wave-emoji'));

      await tester.pumpWidget(parent);

      expect(waveEmoji, findsOneWidget);

  });
  
}

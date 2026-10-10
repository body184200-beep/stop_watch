import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stop_watch/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TimeApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

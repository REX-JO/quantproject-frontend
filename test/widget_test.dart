// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_web_1/main.dart';

void main() {
  testWidgets('Dashboard initial content smoke test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CryptoDashboardApp());

    expect(find.text('加密貨幣儀表板'), findsOneWidget);
    expect(find.textContaining('BTC、ETH、SOL、XRP'), findsWidgets);
    expect(find.textContaining('不構成投資建議'), findsOneWidget);
  });

  testWidgets('手機點擊可展開加密貨幣選單', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CryptoDashboardApp());
    expect(find.text('BTC'), findsNothing);

    await tester.tap(find.text('加密貨幣').first);
    await tester.pumpAndSettle();

    expect(find.text('BTC'), findsOneWidget);
    expect(find.text('ETH'), findsOneWidget);
    expect(find.text('SOL'), findsOneWidget);
    expect(find.text('XRP'), findsOneWidget);
  });
}

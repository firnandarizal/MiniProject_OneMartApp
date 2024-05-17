import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing Login Screen 1 form', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(home: Login()));

    expect(find.byKey(const Key('formUser')), findsOneWidget);
    expect(find.byKey(const Key('loginButton')), findsOneWidget);

    await widgetTester.pump();
  });
}

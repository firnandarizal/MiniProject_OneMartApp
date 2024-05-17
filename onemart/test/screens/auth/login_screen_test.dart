import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing Login Screen 2 Form 1 Button',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(home: Login()));

    expect(find.byKey(const Key('loginButton')), findsOneWidget);
    expect(find.byKey(const Key('formUser')), findsOneWidget);
    expect(find.byKey(const Key('formPassword')), findsOneWidget);


    await widgetTester.pump();
  });
}

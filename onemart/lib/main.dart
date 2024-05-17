import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/decision_page.dart';
import 'package:flutter_application_1/screens/main_screens/invoice.dart';
import 'package:flutter_application_1/screens/main_screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Move MultiProvider here
      providers: [
        ChangeNotifierProvider(
            create: (_) => DateTimeProvider()), // Add DateTimeProvider
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {'/login': (context) => const DecisionPage()},
      ),
    );
  }
}

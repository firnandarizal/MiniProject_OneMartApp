import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DecisionPage extends StatefulWidget {
  const DecisionPage({super.key});

  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('user_nama');

    if (userName != null && userName.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

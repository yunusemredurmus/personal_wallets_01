import 'package:flutter/material.dart';
import 'package:personal_wallets_01/Screens/LoginSreen.dart';
import 'package:personal_wallets_01/component/bottomNav/bottomnavbar.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _isLoggedIn ? Material(child: BottomBar()) : LoginScreen(),
      ),
    );
  }
}

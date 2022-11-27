import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  static const backgroundColor = Color.fromRGBO(36, 43, 85, 1);
  static const textColor = Color.fromRGBO(244, 237, 219, 1);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: backgroundColor,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: textColor,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

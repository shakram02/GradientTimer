import 'package:flutter/material.dart';
import 'package:timer/timer/view/timer_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timez',
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: const ColorScheme.light(secondary: Colors.amberAccent),
      ),
      home: const TimerPage(),
    );
  }
}

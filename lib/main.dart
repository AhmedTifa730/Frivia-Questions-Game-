import 'package:coin_cap/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Frivia());
}

class Frivia extends StatelessWidget {
  const Frivia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Architects Daughter',
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
      ),
      title: 'Frivia',
      debugShowCheckedModeBanner: false,
      home: const HomeA(),
    );
  }
}

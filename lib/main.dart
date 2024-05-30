import 'package:flutter/material.dart';
import 'package:flutter_w10_3th_d11_pomodoro/screens/pomodoro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFE64D3D),
          onPrimary: Colors.white,
          secondary: Colors.black,
          onSecondary: Colors.white,
          background: Color(0xFFE64D3D),
          onBackground: Colors.white,
          error: Color(0xFFE64D3D),
          onError: Colors.white,
          surface: Color(0xFFE64D3D),
          onSurface: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      home: const Pomodoro(),
    );
  }
}

import 'package:flutter/material.dart';
import 'login.dart'; // Import de la page de login

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recommandation de Patrons de Conception',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.orange, // Use secondary for accent color
        ),
        buttonTheme: ButtonThemeData(buttonColor: Colors.orangeAccent),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Updated from bodyText2
        ),
      ),
      home: LoginScreen(), // Page de login
    );
  }
}

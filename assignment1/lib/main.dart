import 'package:assignment1/list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assignment#1',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorSchemeSeed: Colors.amber,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[100],
          ),
        ),
        darkTheme: ThemeData(
            colorSchemeSeed: Colors.amber,
            useMaterial3: true,
            brightness: Brightness.dark),
        home: const UserUi());
  }
}

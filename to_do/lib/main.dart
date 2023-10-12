import 'package:flutter/material.dart';
import 'package:to_do/screens/login_screen.dart';
import 'package:to_do/widgets/custom_grid.dart';

//
void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          centerTitle: true,
          title: const Text(
            'Products',
          ),
        ),
        body: const LoginPage(),
      ),
    );
  }
}

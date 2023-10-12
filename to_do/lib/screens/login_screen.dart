import 'package:flutter/material.dart';
import 'package:to_do/widgets/custom_grid.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passwordHidden = true;

  void navigateToNextScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CustomGrid(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/humming_bird_logo_4x.jpg",
                scale: 10,
              ),
              const Text('Shrine'),
              const SizedBox(height: 120),
              TextField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordHidden = !passwordHidden;
                      });
                    },
                    icon: Icon(passwordHidden
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                obscureText: passwordHidden,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _userNameController.clear();
                      _passwordController.clear();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      navigateToNextScreen();
                    },
                    child: const Text('Next'),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:firebase1/signup.dart';
import 'package:flutter/material.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Image(
                    width: MediaQuery.sizeOf(context).width,
                    image: const AssetImage("assets/asset1.png"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 47,
                      ),
                      Text(
                        'Log In',
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  )
                ],
              ),
              SizedBox(
                  width: 320,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.purple),
                            ),
                            hintText: 'Email',
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          validator: (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                value.length > 50) {
                              return 'Text is too long (max 50 characters).';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 25),
              SizedBox(
                width: 320,
                child: TextFormField(
                  maxLength: 20,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.purple),
                    ),
                    hintText: 'Password',
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 320,
                height: 55,
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: const Text('Sign in'),
                ),
              ),
              SizedBox(
                width: 320,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Don't have an account?",
                        style: TextStyle(fontSize: 12)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      child: const Text(
                        "Sign up",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 335,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?",
                          style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

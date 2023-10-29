import 'package:flutter/material.dart';

final GlobalKey<FormState> _formKeySignup = GlobalKey<FormState>();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  width: MediaQuery.sizeOf(context).width,
                  image: const AssetImage("assets/asset2.png"),
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
                          'Sign Up',
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
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.purple),
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
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(
                      width: 37,
                    ),
                    SizedBox(
                      width: 150,
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
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 150,
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
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 330,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      if (_formKeySignup.currentState!.validate()) {}
                    },
                    child: const Text(
                      "Create account",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  width: 320,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(fontSize: 12)),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Log in",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

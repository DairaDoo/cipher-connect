import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(height: 50),
            // logo
            Icon(Icons.lock, size: 100),

            SizedBox(height: 50),

            // welcome back, you've been missed
            Text(
              'Welcome Back You\'ve been missed!',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),

            SizedBox(height: 25),

            // username textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
              ),
            )
            // password textfield

            // forgot password

            // sign in button

            // or continue with

            // not a member? register now
          ]),
        ),
      ),
    );
  }
}

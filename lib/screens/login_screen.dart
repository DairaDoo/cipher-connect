import 'package:flutter/material.dart';
import '../widgets/my_textfield.dart';
import '../widgets/my_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
            MyTextField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),

            const SizedBox(height: 10),

            // password textfield
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            // forgot password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot Password?',
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // sign in button
            MyButton(),
            // or continue with

            // not a member? register now
          ]),
        ),
      ),
    );
  }
}

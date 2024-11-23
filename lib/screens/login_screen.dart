// login_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/my_textfield.dart';
import '../widgets/my_button.dart';
import 'otp_form_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Método futuro encargado de logear al usuario.
  void signUserIn() {
    // Usuario falso para prueba
    const fakeUsername = 'testuser';
    const fakePassword = '123456';

    if (usernameController.text == fakeUsername &&
        passwordController.text == fakePassword) {
      // Navegar a la pantalla OTP si el usuario es válido
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpForm(),
        ),
      );
    } else {
      // Mostrar un error si las credenciales son inválidas
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 600,
                minHeight: mediaQuery.size.height - 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Cipher Connect',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 30 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.security,
                          size: 60,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Welcome Back,\nYou\'ve been missed!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        const SizedBox(height: 20),
                        MyTextField(
                          controller: usernameController,
                          hintText: 'Username',
                          obscureText: false,
                        ),
                        const SizedBox(height: 12),
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: MyButton(
                            onTap: signUserIn,
                          ),
                        ),
                        const SizedBox(height: 30),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                            children: [
                              const TextSpan(text: 'Not a member? '),
                              TextSpan(
                                text: 'Register now',
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Not implemented yet!'),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

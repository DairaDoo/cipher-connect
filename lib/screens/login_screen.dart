import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/my_textfield.dart';
import '../widgets/my_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Método futuro encargado de logear al usuario.
  void signUserIn() {}

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
                maxWidth: 600, // Anchura máxima para pantallas grandes
                minHeight:
                    mediaQuery.size.height - 40, // Altura mínima sin overflow
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centrado vertical
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título de la app
                  Text(
                    'Cipher Connect',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 30 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontFamily: 'Poppins', // Fuente Poppins
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Cuadro con el contenido de login
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
                        // Logo
                        const Icon(
                          Icons.security,
                          size: 60,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 15),

                        // Texto de bienvenida
                        Text(
                          'Welcome Back,\nYou\'ve been missed!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto', // Fuente Roboto
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Username textfield
                        MyTextField(
                          controller: usernameController,
                          hintText: 'Username',
                          obscureText: false,
                        ),
                        const SizedBox(height: 12),

                        // Password textfield
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 8),

                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Acción para "Forgot Password"
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                                fontFamily: 'Roboto', // Fuente Roboto
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sign in button
                        SizedBox(
                          width: double.infinity,
                          child: MyButton(
                            onTap: signUserIn,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Register now
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
                                  fontFamily: 'Roboto', // Fuente Roboto
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Acción para registrar
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

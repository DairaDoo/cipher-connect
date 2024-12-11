import 'package:cipher_connect/screens/game_screen.dart';

import '../screens/password_manager_page.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpForm extends StatelessWidget {
  OtpForm({super.key, required this.otp});

  final String otp; // Aceptamos el parámetro 'otp'
  final pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Función para hacer la solicitud POST a la ruta 'verify_otp'
  // Función para hacer la solicitud POST a la ruta 'verify_otp'
  Future<void> verifyOtp(BuildContext context) async {
    final otpEntered = pinController.text; // El OTP ingresado por el usuario

    if (otpEntered.length == 6) {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/verify_otp'), // Reemplaza con tu URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'otp': otpEntered, // Solo enviamos el OTP
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification Successful')),
        );
        // Redirige a la pantalla de PasswordManagerPage después de una verificación exitosa
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CeaserCipherGame(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;

    // Temas de los campos PIN
    final defaultPinTheme = PinTheme(
      width: isMobile ? 50 : 56,
      height: isMobile ? 50 : 56,
      textStyle: TextStyle(
        fontSize: isMobile ? 18 : 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.blueAccent),
      borderRadius: BorderRadius.circular(12),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.blue[50],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600, // Anchura máxima para pantallas grandes
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo y título
                  const Icon(
                    Icons.security,
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Cipher Connect',
                    style: TextStyle(
                      fontSize: isMobile ? 30 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tarjeta de 2FA
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
                        // Subtítulo
                        Text(
                          'Two-Factor Authentication',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Instrucción
                        Text(
                          'Enter the 6-digit code sent to your email/phone.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: isMobile ? 14 : 16,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Formulario para el PIN
                        Form(
                          key: formKey,
                          child: Pinput(
                            controller: pinController,
                            length: 6,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Botón de verificación
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                verifyOtp(
                                    context); // Llamada a la función de verificación
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                            ),
                            child: const Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Enlace para regresar al login
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PasswordManagerPage(),
                              ),
                            ); // redireccionar al juego ceaser cipher
                          },
                          child: const Text(
                            'Back to Login',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationThickness:
                                  1.0, // Ajusta el grosor de la línea
                              height:
                                  1.2, // Controla la altura del texto, bajando el subrayado ligeramente
                            ),
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

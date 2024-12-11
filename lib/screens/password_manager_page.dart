import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class PasswordManagerPage extends StatefulWidget {
  const PasswordManagerPage({super.key});

  @override
  _PasswordManagerPageState createState() => _PasswordManagerPageState();
}

class _PasswordManagerPageState extends State<PasswordManagerPage> {
  final _storage = const FlutterSecureStorage();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _key = encrypt.Key.fromUtf8(
      '32characterslongencryptionkey12345'); // 32 bytes key
  final _iv = encrypt.IV.fromLength(16); // 16 bytes IV

  // Colores personalizados
  final Color _primaryColor = const Color(0xFF1D2A44); // Azul oscuro
  final Color _secondaryColor = const Color(0xFFC19A6B); // Dorado
  final Color _accentColor =
      Colors.white; // Blanco para fondo de botones y campos de texto

  // Método para cifrar la contraseña antes de guardarla
  String _encryptPassword(String password) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    return encrypter.encrypt(password, iv: _iv).base64;
  }

  // Método para guardar la contraseña cifrada
  Future<void> _savePassword() async {
    String encryptedPassword = _encryptPassword(_passwordController.text);
    await _storage.write(
        key: _serviceController.text, value: encryptedPassword);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password saved successfully")));
    setState(() {});
  }

  // Método para descifrar la contraseña
  String _decryptPassword(String encryptedPassword) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    return encrypter.decrypt64(encryptedPassword, iv: _iv);
  }

  // Método para obtener y mostrar las contraseñas
  Future<String?> _getPassword(String service) async {
    String? encryptedPassword = await _storage.read(key: service);
    if (encryptedPassword != null) {
      return _decryptPassword(encryptedPassword);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Password Manager",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: _primaryColor, // Azul oscuro
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Service Name:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            const SizedBox(height: 12),
            // Campo de texto para ingresar el nombre del servicio
            TextField(
              controller: _serviceController,
              decoration: InputDecoration(
                hintText: 'e.g., Amazon, Google',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: _primaryColor, width: 2),
                ),
                filled: true,
                fillColor: _accentColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Enter Password:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            const SizedBox(height: 12),
            // Campo de texto para ingresar la contraseña
            TextField(
              controller: _passwordController,
              obscureText: true, // Para ocultar la contraseña
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: _primaryColor, width: 2),
                ),
                filled: true,
                fillColor: _accentColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Botón para guardar la contraseña
            ElevatedButton(
              onPressed: _savePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor, // Azul oscuro
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
              ),
              child: const Text('Save Password',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 20),

            const Text(
              'Retrieve Password:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            const SizedBox(height: 12),
            // Campo de texto para recuperar la contraseña
            TextField(
              controller: _serviceController,
              decoration: InputDecoration(
                hintText: 'Enter service name to retrieve password',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: _primaryColor, width: 2),
                ),
                filled: true,
                fillColor: _accentColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Botón para recuperar la contraseña
            ElevatedButton(
              onPressed: () async {
                String? password = await _getPassword(_serviceController.text);
                if (password != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password: $password")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("No password found for this service")));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _secondaryColor, // Dorado
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
              ),
              child: const Text('Retrieve Password',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

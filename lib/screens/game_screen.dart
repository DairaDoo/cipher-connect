import 'package:flutter/material.dart';

class CeaserCipherGame extends StatefulWidget {
  const CeaserCipherGame({super.key});

  @override
  _CeaserCipherGameState createState() => _CeaserCipherGameState();
}

class _CeaserCipherGameState extends State<CeaserCipherGame> {
  final TextEditingController _shiftController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  String resultText = '';

  // Colores personalizados en tonos pastel
  final Color _primaryColor = const Color(0xFF70A1D7); // Azul pastel
  final Color _secondaryColor = const Color(0xFFF7C6A3); // Amarillo pastel
  final Color _accentColor = const Color(0xFFF5E6CC); // Crema claro
  final Color _buttonTextColor =
      const Color(0xFF4A4A4A); // Gris oscuro para texto de botones
  final Color _headerColor =
      const Color(0xFFB4C7D9); // Azul suave para el encabezado

  // Función para cifrar texto con Caesar Cipher
  String caesarCipher(String text, int shift, bool encrypt) {
    final normalizedShift = (encrypt ? shift : -shift) % 26;
    return text.split('').map((char) {
      if (char.contains(RegExp(r'[a-zA-Z]'))) {
        final isUpperCase = char == char.toUpperCase();
        final asciiOffset = isUpperCase ? 65 : 97;
        final encryptedChar =
            ((char.codeUnitAt(0) - asciiOffset + normalizedShift) % 26 + 26) %
                    26 +
                asciiOffset;
        return String.fromCharCode(encryptedChar);
      } else {
        return char; // No cambia caracteres no alfabéticos
      }
    }).join('');
  }

  // Métodos para encriptar y desencriptar con Caesar Cipher
  void encryptText() {
    final text = textController.text;
    final shift = int.tryParse(_shiftController.text) ?? 0;
    setState(() {
      resultText = caesarCipher(text, shift, true);
    });
  }

  void decryptText() {
    final text = textController.text;
    final shift = int.tryParse(_shiftController.text) ?? 0;
    setState(() {
      resultText = caesarCipher(text, shift, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caesar Cipher Game'),
        backgroundColor: _headerColor, // Azul suave para encabezado
        elevation: 4,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: _buttonTextColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Text for Caesar Cipher:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),
            // Campo de texto para ingresar texto para encriptar
            TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _primaryColor, width: 2),
                ),
                hintText: 'Type your text here...',
                filled: true,
                fillColor: _accentColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Shift Value:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Campo de texto para ingresar el valor del desplazamiento
            TextField(
              controller: _shiftController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _primaryColor, width: 2),
                ),
                hintText: 'Enter shift value...',
                filled: true,
                fillColor: _accentColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: encryptText,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Encrypt',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: decryptText,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _secondaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Decrypt',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _accentColor,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(resultText, style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

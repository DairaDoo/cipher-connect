import 'package:flutter/material.dart';

class CaesarCipherGame extends StatefulWidget {
  @override
  _CaesarCipherGameState createState() => _CaesarCipherGameState();
}

class _CaesarCipherGameState extends State<CaesarCipherGame> {
  final textController = TextEditingController();
  final shiftController = TextEditingController();
  String resultText = '';

  // Función para cifrar texto
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

  void encryptText() {
    final text = textController.text;
    final shift = int.tryParse(shiftController.text) ?? 0;
    setState(() {
      resultText = caesarCipher(text, shift, true);
    });
  }

  void decryptText() {
    final text = textController.text;
    final shift = int.tryParse(shiftController.text) ?? 0;
    setState(() {
      resultText = caesarCipher(text, shift, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caesar Cipher Game'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type your text here...',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Shift Value:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: shiftController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter shift value...',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: encryptText,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Encrypt'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: decryptText,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Decrypt'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                resultText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

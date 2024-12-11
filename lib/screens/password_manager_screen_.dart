import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PasswordManagerScreen extends StatefulWidget {
  const PasswordManagerScreen({super.key});

  @override
  _PasswordManagerScreenState createState() => _PasswordManagerScreenState();
}

class _PasswordManagerScreenState extends State<PasswordManagerScreen> {
  final _storage = const FlutterSecureStorage();
  Map<String, String> _savedPasswords = {};

  @override
  void initState() {
    super.initState();
    _loadSavedPasswords();
  }

  Future<void> _loadSavedPasswords() async {
    final allPasswords = await _storage.readAll();
    setState(() {
      _savedPasswords = allPasswords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password Manager"),
      ),
      body: _savedPasswords.isEmpty
          ? const Center(
              child: Text("No passwords saved"),
            )
          : ListView.builder(
              itemCount: _savedPasswords.length,
              itemBuilder: (context, index) {
                String service = _savedPasswords.keys.elementAt(index);
                return ListTile(
                  leading: const Icon(Icons.security, color: Colors.blue),
                  title: Text(service),
                  subtitle: Text("Password: ${_savedPasswords[service]}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await _storage.delete(key: service);
                      _loadSavedPasswords();
                    },
                  ),
                );
              },
            ),
    );
  }
}

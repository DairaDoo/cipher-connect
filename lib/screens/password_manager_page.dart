import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class PasswordManagerPage extends StatefulWidget {
  @override
  _PasswordManagerPageState createState() => _PasswordManagerPageState();
}

class _PasswordManagerPageState extends State<PasswordManagerPage> {
  TextEditingController _serviceController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Función para guardar la contraseña
  void _savePassword() {
    String service = _serviceController.text;
    String password = _passwordController.text;

    if (service.isNotEmpty && password.isNotEmpty) {
      // Guardar la contraseña en localStorage
      StorageService.saveCredentials(service, password);
      setState(() {});
      _serviceController.clear();
      _passwordController.clear();
    }
  }

  // Función para eliminar las credenciales almacenadas
  void _clearCredentials(String service) {
    StorageService.removeCredentials(service);
    setState(() {});
  }

  // Mostrar detalles de la contraseña del servicio en un cuadro de diálogo
  void _showPasswordDetails(String service) {
    String? password = StorageService.getPassword(service);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Service: $service'),
          content: Text('Password: $password'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> services = StorageService.getAllServices();

    return Scaffold(
      appBar: AppBar(
        title: Text('Password Manager',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de entrada para el servicio
            TextField(
              controller: _serviceController,
              decoration: InputDecoration(
                labelText: 'Service',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.business),
              ),
            ),
            SizedBox(height: 10),
            // Campo de entrada para la contraseña
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            // Botón para guardar la contraseña
            ElevatedButton(
              onPressed: _savePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text('Save Password'),
            ),
            SizedBox(height: 20),
            Text(
              'Stored Services:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  String service = services[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(service,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text('Click to view details'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _clearCredentials(service),
                      ),
                      onTap: () => _showPasswordDetails(service),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

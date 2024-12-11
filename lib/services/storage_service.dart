import 'dart:html';

class StorageService {
  // Guardar datos en localStorage
  static void saveCredentials(String service, String password) {
    window.localStorage['$service-password'] = password;
  }

  // Obtener datos de localStorage
  static String? getPassword(String service) {
    return window.localStorage['$service-password'];
  }

  // Eliminar datos de localStorage
  static void removeCredentials(String service) {
    window.localStorage.remove('$service-password');
  }

  // Listar todos los servicios guardados
  static List<String> getAllServices() {
    List<String> services = [];
    window.localStorage.forEach((key, value) {
      if (key.endsWith('-password')) {
        services.add(key.split('-')[0]); // Extraer el nombre del servicio
      }
    });
    return services;
  }
}

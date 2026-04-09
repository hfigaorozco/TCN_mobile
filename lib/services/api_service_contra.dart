import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/usuario.dart';
import '../config.dart';

class ApiServiceContra {
  static const String baseUrl = Config.baseUrl;

  Future<void> cambiarContra(
    String nuevo_password,
    String actual_password,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('1. TOKEN ENCONTRADO: "$token"'); // ← ¿Qué muestra?
    print('2. TOKEN ES NULL? ${token == null}');
    print('3. TOKEN ESTÁ VACÍO? ${token?.isEmpty}');
    final url = Uri.parse('$baseUrl/contraseña/');

    final headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };
    print('HEADER COMPLETO: $headers');
    final respuesta = await http.put(
      url,
      headers: headers,
      body: jsonEncode({
        'actual_password': actual_password,
        'nuevo_password': nuevo_password,
      }),
    );

    if (respuesta.statusCode == 204) {
      return print('Hoy se acaba el proyecto');
    } else {
      print(respuesta.body);
      throw Exception('Error al actualizar la contrasenia');
    }
  }
}

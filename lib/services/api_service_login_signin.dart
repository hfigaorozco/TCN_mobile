import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/usuario.dart';
import '../models/login_respuesta.dart';
import '../config.dart';

class ApiServiceLoginSignin {
  static const String baseUrl = Config.baseUrl;

  //Guardar el token de Login
  Future<void> guardarToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  //Obtener el token guardado
  Future<String?> obtenerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  //Eliminar el token para logout
  Future<void> quitarToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  //Obtener headers con token
  Future<Map<String, String>> _obtenerHeaders() async {
    final token = await obtenerToken();
    return {
      'content-Type': 'application/json',
      'Authorization': 'Token $token',
    };
  }

  //Registro
  Future<Usuario> registrar(
    String nombre,
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/registro/');

    final respuesta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'email': email,
        'password': password,
      }),
    );

    if (respuesta.statusCode == 201) {
      return Usuario.fromJson(jsonDecode(respuesta.body));
    } else {
      throw Exception(' Error al registrar: ${respuesta.body}');
    }
  }

  //Login
  Future<LoginRespuesta> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login/');
    final respuesta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (respuesta.statusCode == 200) {
      final data = jsonDecode(respuesta.body);
      print(data);
      final loginRespuesta = LoginRespuesta.fromJson(data);
      await guardarToken(loginRespuesta.token);
      return loginRespuesta;
    } else {
      throw Exception('Error al iniciar sesion: ${respuesta.body}');
    }
  }
}

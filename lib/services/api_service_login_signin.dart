import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/usuario.dart';
import '../models/login_respuesta.dart';
import '../config.dart';

class ApiServiceLoginSignin {
  static const String baseUrl = Config.baseUrl;

  //Guardar el token
  Future<void> guardarToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  //Guardar datos de usuario
  Future<void> guardarDatosUsuario(int id, String nombre, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id);
    await prefs.setString('nombre', nombre);
    await prefs.setString('email', email);
  }

  //Obtener el token
  Future<String?> obtenerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  //Obtener datos de ususario guardados
  Future<Map<String, dynamic>> obtenerDatosUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getInt('id'),
      'email': prefs.getString('email'),
      'nombre': prefs.getString('nombre'),
    };
  }

  //Eliminar los datos de usuario para logout
  Future<void> quitarToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('id');
    await prefs.remove('email');
    await prefs.remove('nombre');
  }

  //Obtener headers con token
  Future<Map<String, String>> _obtenerHeaders() async {
    final token = await obtenerToken();
    return {
      'Content-Type': 'application/json',
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
      final loginRespuesta = LoginRespuesta.fromJson(data);
      await guardarToken(loginRespuesta.token);
      await guardarDatosUsuario(
        loginRespuesta.id,
        loginRespuesta.nombre,
        loginRespuesta.email,
      );
      return loginRespuesta;
    } else {
      throw Exception('Error al iniciar sesion: ${respuesta.body}');
    }
  }
}
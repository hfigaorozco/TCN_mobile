import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/usuario.dart';
import '../models/login_respuesta.dart';
import '../config.dart';

class ApiServiceLoginSignin {
  static const String baseUrl = Config.baseUrl;

  //Guardar el token de Login
  Future<void> guardarToken(String token) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  //Obtener el token guardado
  Future<String?> obtenerToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<String> quitarToken()
}
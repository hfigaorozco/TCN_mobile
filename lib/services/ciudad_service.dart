import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ciudad.dart';
import '../config.dart'; 

class CiudadService {
  static Future<List<Ciudad>> obtenerCiudades() async {
    final url = Uri.parse('${Config.baseUrl}/ciudades/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Ciudad.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar ciudades');
    }
  }
}
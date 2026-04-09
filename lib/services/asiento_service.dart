import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/corrida_asiento.dart';
import '../config.dart';

class AsientoService {
  static Future<List<CorridaAsiento>> obtenerAsientos(int corridaId) async {
    final url = Uri.parse('${Config.baseUrl}/corridas/$corridaId/asientos/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => CorridaAsiento.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar asientos');
    }
  }
}
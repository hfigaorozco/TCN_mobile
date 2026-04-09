import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/corrida.dart';
import '../config.dart';

class CorridaService {
  static Future<List<Corrida>> buscarCorridas({
    required String origen,
    required String destino,
    required DateTime fecha,
    required int pasajeros,
  }) async {
    // Formato YYYY-MM-DD que espera Django
    final fechaStr =
        '${fecha.year}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}';

    final url = Uri.parse('${Config.baseUrl}/corridas/buscar/').replace(
      queryParameters: {
        'origen':    origen,
        'destino':   destino,
        'fecha':     fechaStr,
        'pasajeros': pasajeros.toString(),
      },
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Corrida.fromJson(e)).toList();
    } else {
      throw Exception('Error al buscar corridas: ${response.statusCode}');
    }
  }
}
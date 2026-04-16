import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reservacion_response.dart';
import '../config.dart';

class ReservacionService {
  static Future<List<ReservacionResponse>> obtenerReservaciones(int usuarioId) async {
    final url = Uri.parse('${Config.baseUrl}/reservaciones/$usuarioId/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => ReservacionResponse.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return []; // sin reservaciones
    } else {
      throw Exception('Error al cargar reservaciones');
    }
  }
}
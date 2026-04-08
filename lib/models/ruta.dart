import 'ciudad.dart';

class Ruta {
  final String codigo;
  final double distancia;
  final Ciudad ciudadDestino;
  final Ciudad ciudadOrigen;

  Ruta({
    required this.codigo,
    required this.distancia,
    required this.ciudadDestino,
    required this.ciudadOrigen,
  });

  factory Ruta.fromJson(Map<String, dynamic> json) {
    return Ruta(
      codigo: json['codigo'],
      distancia: json['distancia'],
      ciudadDestino: Ciudad.fromJson(json['ciudadDestino']),
      ciudadOrigen: Ciudad.fromJson(json['ciudadOrigen']),
    );
  }
}

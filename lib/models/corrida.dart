class Corrida {
  final int numero;
  final String horaSalida;
  final String fechaSalida;
  final String horaLlegada;
  final String fechaLlegada;
  final double tarifaBase;
  final int lugaresDisp;
  final int autobus;
  final String ruta;
  final int operador;
  final String estado;
  final String ciudadOrigen;
  final String ciudadDestino;
  final String tipoAutobus;   // nuevo: 'PLAT' o 'PLUS'

  Corrida({
    required this.numero,
    required this.horaSalida,
    required this.fechaSalida,
    required this.horaLlegada,
    required this.fechaLlegada,
    required this.tarifaBase,
    required this.lugaresDisp,
    required this.autobus,
    required this.ruta,
    required this.operador,
    required this.estado,
    required this.ciudadOrigen,
    required this.ciudadDestino,
    required this.tipoAutobus,
  });

  factory Corrida.fromJson(Map<String, dynamic> json) {
    return Corrida(
      numero:        json['numero'],
      horaSalida:    json['hora_salida'],
      fechaSalida:   json['fecha_salida'],
      horaLlegada:   json['hora_llegada'],
      fechaLlegada:  json['fecha_llegada'],
      tarifaBase:    (json['tarifaBase'] as num).toDouble(),
      lugaresDisp:   json['lugaresDisp'],
      autobus:       json['autobus'],
      ruta:          json['ruta'],
      operador:      json['operador'],
      estado:        json['estado'],
      ciudadOrigen:  json['ciudadOrigen'],
      ciudadDestino: json['ciudadDestino'],
      tipoAutobus:   json['tipoAutobus'],   // nuevo
    );
  }
}
class Corrida {
  final int numero;
  final String hora_salida;
  final String fecha_salida;
  final String hora_llegada;
  final String fecha_llegada;
  final double tarifaBase;
  final int lugaresDisp;
  final int autobus;
  final String ruta;
  final int operador;
  final String estado;

  Corrida({
    required this.numero,
    required this.hora_salida,
    required this.fecha_salida,
    required this.hora_llegada,
    required this.fecha_llegada,
    required this.tarifaBase,
    required this.lugaresDisp,
    required this.autobus,
    required this.ruta,
    required this.operador,
    required this.estado,
  });

  factory Corrida.fromJson(Map<String, dynamic> json){
    return Corrida(
      numero: json['numero'],
      hora_salida: json['hora_salida'],
      fecha_salida: json['fecha_salida'],
      hora_llegada: json['hora_llegada'],
      fecha_llegada: json['fecha_llegada'],
      tarifaBase: json['tarifaBase'],
      lugaresDisp: json['lugaresDisp'],
      autobus: json['autobus'],
      ruta: json['ruta'],
      operador: json['operador'],
      estado: json['estado']
    );
  }
}


class CorridaAsiento {
  final int corrida;
  final String asiento;  
  final String estado;

  CorridaAsiento({
    required this.corrida,
    required this.asiento,
    required this.estado,
  });


  int get numero => int.parse(asiento.split('-')[1]);

  factory CorridaAsiento.fromJson(Map<String, dynamic> json) {
    return CorridaAsiento(
      corrida: json['corrida'],
      asiento: json['asiento'],
      estado:  json['estado'],
    );
  }
}
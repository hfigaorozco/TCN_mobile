class Ciudad {
  final String codigo;
  final String nombre;

  Ciudad({required this.codigo, required this.nombre});

  factory Ciudad.fromJson(Map<String, dynamic> json) {
    return Ciudad(codigo: json['codigo'], nombre: json['nombre']);
  }
}

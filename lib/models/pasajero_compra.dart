class PasajeroCompra {
  final String nombre;
  final String apellPat;
  final String apellMat;
  final int edad;
  final String tipoPasajero;
  final String asientoClave;   
  final int asientoNumero;     

  PasajeroCompra({
    required this.nombre,
    required this.apellPat,
    required this.apellMat,
    required this.edad,
    required this.tipoPasajero,
    required this.asientoClave,
    required this.asientoNumero,
  });

  Map<String, dynamic> toJson() => {
    'nombre':        nombre,
    'apellPat':      apellPat,
    'apellMat':      apellMat,
    'edad':          edad,
    'tipoPasajero':  tipoPasajero,
    'asiento':       asientoClave,
    'asientoNumero': asientoNumero,
  };
}
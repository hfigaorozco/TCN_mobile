class BoletoResponse {
  final int numero;
  final double precio;
  final String asientoClave;
  final int asientoNumero;
  final String tipoPasajero;
  final String tipoPasajeroDesc;
  final String nombrePasajero;   // nuevo

  BoletoResponse({
    required this.numero,
    required this.precio,
    required this.asientoClave,
    required this.asientoNumero,
    required this.tipoPasajero,
    required this.tipoPasajeroDesc,
    required this.nombrePasajero,
  });

  factory BoletoResponse.fromJson(Map<String, dynamic> json) {
    final p = json['pasajero'];
    final apellMat = (p['apellMat'] != null && p['apellMat'].toString().isNotEmpty)
        ? ' ${p['apellMat']}'
        : '';

    return BoletoResponse(
      numero:           json['numero'],
      precio:           (json['precio'] as num).toDouble(),
      asientoClave:     json['asiento']['clave'],
      asientoNumero:    json['asiento']['numero'],
      tipoPasajero:     json['tipoPasajero']['codigo'],
      tipoPasajeroDesc: json['tipoPasajero']['descripcion'],
      nombrePasajero:   '${p['nombre']} ${p['apellPat']}$apellMat',
    );
  }
}

class ReservacionResponse {
  final int numero;
  final String fecha;
  final double subtotal;
  final double iva;
  final double total;
  final int cantPasajeros;
  final String ciudadOrigen;
  final String ciudadDestino;
  final String fechaSalida;
  final String horaSalida;
  final String fechaLlegada;
  final String horaLlegada;
  final int autobus;
  final String estado;
  final List<BoletoResponse> boletos;

  ReservacionResponse({
    required this.numero,
    required this.fecha,
    required this.subtotal,
    required this.iva,
    required this.total,
    required this.cantPasajeros,
    required this.ciudadOrigen,
    required this.ciudadDestino,
    required this.fechaSalida,
    required this.horaSalida,
    required this.fechaLlegada,
    required this.horaLlegada,
    required this.autobus,
    required this.estado,
    required this.boletos,
  });

  factory ReservacionResponse.fromJson(Map<String, dynamic> json) {
    final corrida = json['corrida'];
    final ruta    = corrida['ruta'];
    return ReservacionResponse(
      numero:        json['numero'],
      fecha:         json['fecha'],
      subtotal:      (json['subtotal'] as num).toDouble(),
      iva:           (json['IVA'] as num).toDouble(),
      total:         (json['total'] as num).toDouble(),
      cantPasajeros: json['cantPasajeros'],
      ciudadOrigen:  ruta['ciudadOrigen']['nombre'],
      ciudadDestino: ruta['ciudadDestino']['nombre'],
      fechaSalida:   corrida['fecha_salida'],
      horaSalida:    corrida['hora_salida'],
      fechaLlegada:  corrida['fecha_llegada'],
      horaLlegada:   corrida['hora_llegada'],
      autobus: corrida['autobus'],  
      estado:        corrida['estado'],
      boletos: (json['boletos'] as List)
          .map((b) => BoletoResponse.fromJson(b))
          .toList(),
    );
  }
}
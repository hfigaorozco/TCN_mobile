class LoginRespuesta {
  final String token;
  final int id;
  final String email;
  final String password;
  final String nombre;

  LoginRespuesta({
    required this.token,
    required this.id,
    required this.email,
    required this.password,
    required this.nombre,
  });

  factory LoginRespuesta.fromJson(Map<String, dynamic> json) {
    return LoginRespuesta(
      token: json['token'],
      id: json['id'],
      email: json['email'],
      password: json['password'],
      nombre: json['nombre'],
    );
  }
}

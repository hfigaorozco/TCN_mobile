class LoginRespuesta {
  final String token;
  final int id;
  final String email;
  final String nombre;

  LoginRespuesta({
    required this.token,
    required this.id,
    required this.email,
    required this.nombre,
  });

  factory LoginRespuesta.fromJson(Map<String, dynamic> json) {
    return LoginRespuesta(
<<<<<<< HEAD
      token: json['token'],
      id: json['id'],
      email: json['email'],
      nombre: json['nombre'],
=======
      token: json['token'] ?? '',
      id: json['user_id'] ?? 0,
      email: json['email'] ?? '',
      nombre: json['nombre'] ?? '',
>>>>>>> cf4e63c546ccc370965198365895c28f7c423912
    );
  }
}
import 'dart:convert';

class Usuario {
  String nome;
  String email;
  
  Usuario({
    required this.nome,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source));
}

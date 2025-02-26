import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator; // Permitir validação
  final Color errorColor; // NOVO: Permitir cor customizada para erro

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
this.errorColor = const Color(0xFF000000), // Definir PRETO como padrão
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator, // Validação aplicada aqui
        style: const TextStyle(color: Colors.black), // Texto branco
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black), // Label branco
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white70), // Borda normal
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2), // Borda azul quando focado
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor, width: 2), // ERRO EM ROXO
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor, width: 2), // ERRO EM ROXO
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: TextStyle(color: errorColor), // Texto do erro em ROXO
        ),
      ),
    );
  }
}

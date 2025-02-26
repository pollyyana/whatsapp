import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12), // Espaçamento entre os campos
      child: TextField(
        controller: controller, // Controlador do campo de texto
        keyboardType: keyboardType, // Define o tipo de entrada
        obscureText: obscureText, // Define se o texto será oculto (senha)
        style: const TextStyle(color: Colors.white), // Cor do texto digitado
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              vertical: 18, horizontal: 20), // Padding interno do campo
          hintText: label, // Texto de dica (placeholder)
          hintStyle: const TextStyle(color: Colors.white70), // Cor do hint text
          filled: true, // Ativa fundo colorido
          fillColor: Colors.black54, // Cor de fundo escura translúcida
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20), // Bordas arredondadas
            borderSide:
                const BorderSide(color: Color(0xFF6C63FF)), // Borda roxa neon
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                color: Color(0xFF6C63FF), width: 2), // Borda neon ao focar
          ),
        ),
      ),
    );
  }
}

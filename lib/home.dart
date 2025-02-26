import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user; // Variável para armazenar o usuário logado

  @override
  void initState() {
    super.initState();
    verificarUsuarioLogado();
  }

  void verificarUsuarioLogado() {
    user = FirebaseAuth.instance.currentUser; // Obtém o usuário logado
    if (user == null) {
      // Se não houver usuário logado, redireciona para a tela de login
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      body: Center(
        child: user != null
            ? Text(' ${user!.email}',
                style: const TextStyle(fontSize: 18, color: Colors.black))
            : const CircularProgressIndicator(), // Caso o usuário não esteja carregado ainda
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'custom_textfield.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controladores para capturar os dados dos campos de email e senha
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Definição do fundo com um gradiente que começa preto e transita para roxo neon
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000000), // Preto no topo
              Color(0xFF3D0066), // Roxo escuro no meio
              Color(0xFF6C63FF), // Roxo neon na parte inferior
            ],
            begin: Alignment.topCenter, // Início do gradiente no topo
            end: Alignment.bottomCenter, // Final do gradiente na parte inferior
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 24.0), // Define um espaçamento lateral uniforme
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Centraliza os elementos
                children: [
                  // Exibição da logo do aplicativo
                  Image.asset(
                    'assets/lh.jpg', // Caminho da imagem no projeto
                    width: 180, // Largura da logo
                    height: 130, // Altura da logo
                  ),
                  const SizedBox(height: 30), // Espaço abaixo da logo

                  // Campo de entrada para o Email
                  CustomTextField(
                    controller: emailEC, // Controlador do campo
                    label: 'Email', // Texto do label
                    keyboardType: TextInputType.emailAddress, // Tipo de teclado
                  ),

                  // Campo de entrada para a Senha
                  CustomTextField(
                    controller: passwordEC, // Controlador do campo
                    label: 'Senha', // Texto do label
                    obscureText: true, // Oculta a senha ao digitar
                  ),

                  const SizedBox(height: 25), // Espaçamento antes do botão

                  // Botão de Login
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.6, // Define 60% da largura da tela
                    height: 55, // Altura do botão
                    child: ElevatedButton(
                      onPressed: () {
                        // Aqui será implementada a lógica de login futuramente
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF), // Cor do botão (roxo neon)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Borda arredondada do botão
                        ),
                      ),
                      child: const Text(
                        'Entrar', // Texto do botão
                        style: TextStyle(
                          color: Colors.white, // Cor do texto branco
                          fontSize: 20, // Tamanho da fonte
                          fontWeight: FontWeight.bold, // Texto em negrito
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20), // Espaço antes do link de cadastro

                  // Link para cadastro de novos usuários
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Register())), // Navega para a tela de cadastro
                    child: const Text(
                      'Não tem conta? Cadastre-se', // Texto do link
                      style: TextStyle(
                        color: Colors.white70, // Cor do texto
                        fontSize: 16, // Tamanho da fonte
                        decoration: TextDecoration.underline, // Sublinhado para indicar clique
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

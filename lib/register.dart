import 'package:flutter/material.dart';
import 'custom_textfield.dart'; // Importando seu CustomTextField

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nomeEC = TextEditingController();

  final emailEC = TextEditingController();

  final senhaEC = TextEditingController();

  String mensagemError = "";

  validarCampos() {
    // Captura os valores dos campos
    String nome = nomeEC.text;
    String email = emailEC.text;
    String senha = senhaEC.text;

    if (nome.isNotEmpty && nome.length >= 3 && email.isNotEmpty && senha.isNotEmpty) {
      print("Nome: $nome, Email: $email, Senha: $senha");
    } else {
      setState(() {
        mensagemError = "Preencha todos os campos corretamente!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF6C63FF), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Text(
                          "Seja bem-vindo!",
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Orbitron',
                            letterSpacing: 3,
                            shadows: [
                              Shadow(
                                color: Color(0xFF6C63FF),
                                blurRadius: 20,
                              ),
                              Shadow(
                                color: Color(0xFF6C63FF),
                                blurRadius: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Vamos iniciar seu cadastro :)",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontFamily: 'Orbitron',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // CAMPOS DE TEXTO USANDO SEU CUSTOMTEXTFIELD
                CustomTextField(controller: nomeEC, label: "Nome"),
                CustomTextField(controller: emailEC, label: "E-mail", keyboardType: TextInputType.emailAddress),
                CustomTextField(controller: senhaEC, label: "Senha", obscureText: true),
                
                // BOTÃO DE CADASTRO
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        validarCampos();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    mensagemError,
                    style: const TextStyle(color: Colors.red, fontSize: 17),  
                  ),
                ),
                const SizedBox(
                   height: 40,
                ),
                // LINK PARA LOGIN
                Align(
                  alignment:AlignmentDirectional.bottomEnd,
                  child: GestureDetector(
                    
                      child: const Text(
                        'Voltar para o login',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}

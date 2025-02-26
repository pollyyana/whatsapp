import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:whatsapp/model/usuario.dart';
import 'custom_textfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Chave global para validar o formulário
  final formKey = GlobalKey<FormState>();

  // Controladores para capturar os valores inseridos pelo usuário
  final nomeEC = TextEditingController(text:'pollyana' );
  final emailEC = TextEditingController(text: 'pollyana@gmail.com');
  final senhaEC = TextEditingController(text: '1234567890');

  @override
  void dispose() {
    // Libera os controladores de texto quando a tela for descartada
    nomeEC.dispose();
    emailEC.dispose();
    senhaEC.dispose();
    super.dispose();
  }

  // Função responsável por cadastrar o usuário no Firebase
  Future<void> cadastrarUsuario() async {
    try {
      // Cria um novo usuário no Firebase Authentication com e-mail e senha
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailEC.text,
        password: senhaEC.text,
      );

      // Obtém o UID único do usuário gerado pelo Firebase
      String uid = userCredential.user!.uid;

      // Cria um objeto Usuario para armazenar os dados no Firestore
      Usuario usuario = Usuario(
        nome: nomeEC.text,
        email: emailEC.text,
      );

      // Salva os dados do usuário no Firestore
      await FirebaseFirestore.instance
          .collection('usuarios') // Nome da coleção
          .doc(uid) // Documento identificado pelo UID do usuário
          .set(usuario
              .toMap()); // Converte os dados para um mapa antes de salvar

      // Verifica se o widget ainda está montado antes de acessar o `context`
      //if (!mounted) return; → Evita que o código tente acessar context caso o widget tenha sido desmontado.
      // Aplicado antes de ScaffoldMessenger.of(context) e Navigator.pushReplacementNamed() → Esses métodos dependem do BuildContext, então só
      //são chamados se o widget ainda estiver na árvore de widgets.

      if (!mounted) return;

      // Exibe uma mensagem de sucesso na tela
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastro realizado e salvo no banco!'),
          backgroundColor: Color(0xFF6C63FF), // Cor de fundo da notificação
        ),
      );

      // Verifica novamente se o widget está montado antes de navegar para outra tela
      if (!mounted) return;

      // Redireciona para a tela Home
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      // Verifica se o widget ainda está montado antes de exibir erro
      if (!mounted) return;

      // Exibe uma mensagem de erro caso ocorra falha no cadastro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao cadastrar usuário!'),
          backgroundColor: Colors.red, // Cor vermelha para indicar erro
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Gradiente de fundo
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0E0E0),
              Color(0xFF6C63FF),
              Colors.black,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key:
                  formKey, // Associa o formulário à chave global para validação
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Título da tela
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
                          fontSize: 19,
                          color: Colors.white70,
                          fontFamily: 'Orbitron',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Campo de entrada para Nome
                  CustomTextField(
                    controller: nomeEC,
                    label: "Nome",
                    validator: Validatorless.required('O nome é obrigatório'),
                  ),

                  // Campo de entrada para E-mail
                  CustomTextField(
                    controller: emailEC,
                    label: "E-mail",
                    keyboardType: TextInputType.emailAddress,
                    validator: Validatorless.multiple([
                      Validatorless.required('O e-mail é obrigatório'),
                      Validatorless.email('Digite um e-mail válido'),
                    ]),
                  ),

                  // Campo de entrada para Senha
                  CustomTextField(
                    controller: senhaEC,
                    label: "Senha",
                    obscureText: true, // Oculta a senha para segurança
                    validator: Validatorless.multiple([
                      Validatorless.required('A senha é obrigatória'),
                      Validatorless.min(
                          6, 'A senha deve ter pelo menos 6 caracteres'),
                    ]),
                  ),

                  const SizedBox(height: 25),

                  // Botão de cadastro
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Valida os campos antes de cadastrar
                        if (formKey.currentState?.validate() ?? false) {
                          cadastrarUsuario();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF6C63FF), // Cor do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Link para voltar à tela de login
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: GestureDetector(
                      child: const Text(
                        'Voltar para o login',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      onTap: () {
                        Navigator.pop(context); // Retorna para a tela anterior
                      },
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










// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   // Chave para validar o formulário
//   final formKey = GlobalKey<FormState>();

//   // Controladores para capturar os valores dos campos
//   final nomeEC = TextEditingController();
//   final emailEC = TextEditingController();
//   final senhaEC = TextEditingController();

//   // MÉTODO PARA CADASTRAR O USUÁRIO NO FIREBASE
//   Future<void> cadastrarUsuario() async {
//     try {
//       FirebaseAuth auth = FirebaseAuth.instance;

//       // Criando usuário com email e senha
//       await auth.createUserWithEmailAndPassword(
//         email: emailEC.text.trim(),
//         password: senhaEC.text.trim(),
//       );

//       // Exibe mensagem de sucesso
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Cadastro realizado com sucesso!'),
//           backgroundColor: Color(0xFF6C63FF), // SNACKBAR ROXO
//         ),
//       );

//       // Voltar para a tela de login após o cadastro
//       Navigator.pop(context);
//     } on FirebaseAuthException catch (e) {
//       // TRATANDO ERROS DO FIREBASE
//       String mensagemErro = 'Erro ao cadastrar usuário';

//       if (e.code == 'email-already-in-use') {
//         mensagemErro = 'E-mail já cadastrado. Tente outro!';
//       } else if (e.code == 'invalid-email') {
//         mensagemErro = 'E-mail inválido. Digite um e-mail válido!';
//       } else if (e.code == 'weak-password') {
//         mensagemErro = 'Senha muito fraca. Escolha uma mais segura!';
//       }

//       // Exibir erro personalizado
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(mensagemErro),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } catch (e) {
//       // Caso ocorra um erro inesperado
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Erro inesperado! Tente novamente.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFE0E0E0),
//               Color(0xFF6C63FF),
//               Colors.black,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         padding: const EdgeInsets.all(16),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   // TÍTULO
//                   const Column(
//                     children: [
//                       Center(
//                         child: Padding(
//                           padding: EdgeInsets.only(bottom: 16),
//                           child: Text(
//                             "Seja bem-vindo!",
//                             style: TextStyle(
//                               fontSize: 42,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontFamily: 'Orbitron',
//                               letterSpacing: 3,
//                               shadows: [
//                                 Shadow(
//                                   color: Color(0xFF6C63FF),
//                                   blurRadius: 20,
//                                 ),
//                                 Shadow(
//                                   color: Color(0xFF6C63FF),
//                                   blurRadius: 40,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         "Vamos iniciar seu cadastro :)",
//                         style: TextStyle(
//                           fontSize: 19,
//                           color: Colors.white70,
//                           fontFamily: 'Orbitron',
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // CAMPOS DE TEXTO COM VALIDAÇÃO
//                   CustomTextField(
//                     controller: nomeEC,
//                     label: "Nome",
//                     validator: Validatorless.required('O nome é obrigatório'),
//                   ),
//                   CustomTextField(
//                     controller: emailEC,
//                     label: "E-mail",
//                     keyboardType: TextInputType.emailAddress,
//                     validator: Validatorless.multiple([
//                       Validatorless.required('O e-mail é obrigatório'),
//                       Validatorless.email('Digite um e-mail válido'),
//                     ]),
//                   ),
//                   CustomTextField(
//                     controller: senhaEC,
//                     label: "Senha",
//                     obscureText: true,
//                     validator: Validatorless.multiple([
//                       Validatorless.required('A senha é obrigatória'),
//                       Validatorless.min(6, 'A senha deve ter pelo menos 6 caracteres'),
//                     ]),
//                   ),

//                   const SizedBox(height: 25),

//                   // BOTÃO DE CADASTRO
//                   SizedBox(
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Valida os campos antes de cadastrar
//                         if (formKey.currentState?.validate() ?? false) {
//                           cadastrarUsuario();
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF6C63FF),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       child: const Text(
//                         "Cadastrar",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 40),

//                   // LINK PARA LOGIN
//                   Align(
//                     alignment: AlignmentDirectional.bottomEnd,
//                     child: GestureDetector(
//                       child: const Text(
//                         'Voltar para o login',
//                         style: TextStyle(color: Colors.white70, fontSize: 14),
//                       ),
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
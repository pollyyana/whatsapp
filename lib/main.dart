import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/home.dart';
import 'package:whatsapp/login.dart';
import 'package:whatsapp/register.dart';

void main() async {
  // Garante que os bindings do Flutter estejam inicializados antes de rodar o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa o Firebase antes de iniciar o app
  await Firebase.initializeApp();

  // Instância do Firestore para interagir com o banco de dados
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Exemplo de adição de um documento na coleção "usuarios"
  db.collection("usuarios").doc("003").set({
    "nome": "Jamilton",
    "idade": "31",
  });

  // Inicia o aplicativo chamando a classe MyApp
  runApp(MyApp());
}

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de debug
      theme: ThemeData(
        brightness: Brightness.light, // Define o tema como escuro
        primaryColor: Colors.white, // Cor principal do app
        scaffoldBackgroundColor: Colors.white, // Fundo padrão das telas
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Define o texto como branco
        ),
        
      ),
       initialRoute: "/", // Define a primeira tela
      routes: {
        "/": (context) => Login(), // Tela inicial
        "/home": (context) => const Home(), // Tela de home
        "/cadastro": (context) => const Register(), // Tela de cadastro
      },
    );
  }
}
    
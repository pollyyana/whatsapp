import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF6C63FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(initialEmail: user?.email ?? ""),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: user != null
            ? Text('Bem-vindo, ${user.email}',
                style: const TextStyle(fontSize: 18, color: Colors.black))
            : const CircularProgressIndicator(),
      ),
    );
  }
}

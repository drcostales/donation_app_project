import 'package:flutter/material.dart';
import 'pages/signin.dart';
import 'pages/home.dart';
import 'pages/donor/orglist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donation App Project',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/signin': (context) => const SignInPage(),
        '/orglist': (context) => const OrgList()
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
    );
  }
}

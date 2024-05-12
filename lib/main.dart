import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ())),
        ChangeNotifierProvider(create: ((context) => ()))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPLB Donation App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
      theme: ThemeData(
        primarySwatch: Color.fromARGB(255, 21, 187, 126),
      ),
    );
  }
}
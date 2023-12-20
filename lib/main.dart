import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './firebase_options.dart';
import './services/auth_service.dart';
import './services/service_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return AuthService();
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  TextTheme googleFonts() {
    return GoogleFonts.quicksandTextTheme().copyWith(
      titleSmall: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 22,
      ),
      titleMedium: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        //color: Colors.white,
        fontSize: 22,
      ),
      titleLarge: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        //color: Colors.white,
        fontSize: 40,
      ),
      headlineSmall: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 18,
      ),
      bodySmall: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 22,
      ),
      displaySmall: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        color: Colors.red,
        fontSize: 16,
      ),
    );
  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: googleFonts(),
      ),
      home: const AuthGate(),
    );
  }
}

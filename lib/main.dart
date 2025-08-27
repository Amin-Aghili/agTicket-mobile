// import 'package:ag_ticket/features/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/init_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // make navigation bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  // make flutter draw behind navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Supabase initialization
  await Supabase.initialize(
    url: 'https://zrrypgzzfovkbebsyzih.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpycnlwZ3p6Zm92a2JlYnN5emloIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ4Mjc3MDMsImV4cCI6MjA3MDQwMzcwM30.9eR3O4uBrBn5CPThrjYQIbpZ2LqvaXbVnskxH1lx8Yg',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'agTicket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const InitScreen(),
      // home: supabase.auth.currentSession == null
      //     ? const LoginScreen()
      //     : const InitScreen(),
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}

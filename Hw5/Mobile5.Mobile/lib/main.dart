import 'package:flutter/material.dart';
import 'package:hw5/viewmodels/auth_viewmodel.dart';
import 'package:hw5/views/login_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthViewModel()..tryRestore(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginView());
  }
}

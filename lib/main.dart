import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_nextpak/View/Auth/sign_in_screen.dart';
import 'package:task_nextpak/state_mangement/user_provider.dart' as fbr;
import 'package:task_nextpak/view/auth/sign_up_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => fbr.AuthProviders(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SignInScreen());
  }
}

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/views/pages/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = [EmailAuthProvider()];
    return MaterialApp(
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? "/auth" : "/home",
      title: 'Flutter & Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/auth": (context) {
          return SignInScreen(
            providers: provider,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/home');
              }),
            ],
          );
        },
        "/home": (context) {
          return const HomeScreen();
        },
        "/profile": (context) {
          return ProfileScreen(
            providers: provider,
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/auth');
              }),
            ],
          );
        },
      },
    );
  }
}

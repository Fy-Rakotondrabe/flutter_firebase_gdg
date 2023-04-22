import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/const.dart';
import 'package:flutter_firebase/views/pages/home_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseUIAuth.configureProviders([
    GoogleProvider(
      clientId: googleClientId,
    ),
  ]);

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('-------------token: $fcmToken');

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = [
      EmailAuthProvider(),
    ];
    return MaterialApp(
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? "/auth" : "/home",
      title: 'Flutter & Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
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
            footerBuilder: (context, _) {
              return OAuthProviderButton(
                provider: GoogleProvider(clientId: googleClientId),
              );
            },
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

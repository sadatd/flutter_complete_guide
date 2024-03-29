import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/auth_screen.dart';
import './screens/chat_screen.dart';
import './screens/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            title: 'FlutterChat',
            theme: ThemeData(
              primarySwatch: Colors.green,
              backgroundColor: Colors.green,
              accentColor: Colors.blueGrey,
              accentColorBrightness: Brightness.dark,
              buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.green,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            home: appSnapshot.connectionState != ConnectionState.done
                ? SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SplashScreen();
                      }
                      if (userSnapshot.hasData) { // we got successful login then
                        return ChatScreen();
                      }
                      return AuthScreen();
                    }),
          );
        });
  }
}

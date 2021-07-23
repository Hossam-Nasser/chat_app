// ignore: import_of_legacy_library_into_null_safe
// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:master_chat/screens/auth_Screen.dart';
import 'package:master_chat/screens/chat_screen.dart';
import 'package:master_chat/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.black12,
        primaryColor: Colors.cyan,
        primarySwatch: Colors.cyan,
        accentColor: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return SplashScreen();
          }
          else if(snapshot.hasData){
            return ChatScreen();
          }else {
            return AuthScreen();
          }
        });
  }
}

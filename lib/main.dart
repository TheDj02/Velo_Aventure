import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet/connexion.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp();

  runApp(new MyApp()) ;
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (
            BuildContext ctx,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasData) {
            return FirstPage();
          } else {
            return Connexion();
          }
        },
      ),

    );
  }
}

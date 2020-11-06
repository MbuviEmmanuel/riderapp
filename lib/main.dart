import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riderapp/AllScreens/mainScreen.dart';
import 'package:riderapp/AllScreens/registrationScreen.dart';

import 'AllScreens/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Rider App',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.green,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: MainScreen.idScreen,
      routes: {
        RegistrationScreen.idScreen: (Context) => RegistrationScreen(),
        LoginScreen.idScreen: (Context) => LoginScreen(),
        MainScreen.idScreen: (Context) => MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

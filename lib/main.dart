import 'package:flutter/material.dart';
import 'package:riderapp/AllScreens/mainScreen.dart';
import 'package:riderapp/AllScreens/registrationScreen.dart';

import 'AllScreens/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Rider App',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginScreen.idScreen,
      routes: {
        RegistrationScreen.idScreen: (Context) => RegistrationScreen(),
        LoginScreen.idScreen: (Context) => LoginScreen(),
        MainScreen.idScreen: (Context) => MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

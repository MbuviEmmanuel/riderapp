import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riderapp/AllScreens/mainScreen.dart';
import 'package:riderapp/AllScreens/registrationScreen.dart';
import 'package:riderapp/main.dart';


class LoginScreen extends StatelessWidget {

  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 25.0,),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),

              SizedBox(height: 1.0,),
              Text(
                "Login as Esimusoft Rider",
                style: TextStyle(fontSize: 24, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.04,
                        ),
                      ),

                      style: TextStyle(fontSize: 14.0),
                    ),


                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.04,
                        ),
                      ),

                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 10.0,),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),

                      onPressed: (){
                        if (!emailTextEditingController.text.contains("@")){

                          displayToastMessage("Email address is not valid", context);

                        }else if(passwordTextEditingController.text.isEmpty){

                          displayToastMessage("Please provide Password.", context);

                        }else {
                          loginAndAunthenticateUser(context);
                        }
                      },
                    ),
                  ],

                ),
              ),

              FlatButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Do not have an Account? Register Here",
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAunthenticateUser(BuildContext context) async{
    final User firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword
      (email: emailTextEditingController.text,
        password: passwordTextEditingController.text).catchError((errMsg){
      displayToastMessage("Error" + errMsg.toString(), context);
    })).user;

    if(firebaseUser != null) { //user created
      //save user details to database

      userRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
        if(snap != null){

          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          displayToastMessage("Congratulations, You have logged in successfully", context);
        }
        else {
          _firebaseAuth.signOut();
          displayToastMessage("No record exists for this user. Please create an account to be able to login.", context);
        }
      });

    }
    else{
      // error occurred msg display
      displayToastMessage("Error occurred cannot be signed in.", context);

    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task1/screens/mobile_ntf.dart';
import 'package:task1/screens/reset_password.dart';
import 'package:task1/screens/signup_screen.dart';
import '../utils/color_utils.dart';
import '../widgets/reusable_widgets.dart';
import 'home_screen.dart';
class SignInScreen extends StatefulWidget {

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  hexStringToColor("CB2B93"),
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4")
                ],begin: Alignment.topCenter,end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20,MediaQuery.of(context).size.height* 0.2, 20, 0),
                child: Column(
                  children: <Widget>[
                    logoWidget("assets/images/logo1.png"),
                    const SizedBox(
                      height: 30,
                    ),
                    reusableTextField("Enter UserName", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outline, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 5,
                    ),
                    forgetPassword(context),
                    firebaseUIButton(context,"Sign In", () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                     .then((value) {
                           Navigator.push(context,
                             MaterialPageRoute(builder: (context) => const HomeScreen()));
                               }).onError((error, stackTrace) {
                             print ("Error ${error.toString()}");
                           });
                       }),
                    signUpOption(),
                    ]
                    ),
                ),
              ),
            ),
          ),
        );
  }
  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),


        Padding(padding: EdgeInsets.fromLTRB(10,MediaQuery.of(context).size.height* 0.2, 20, 0),
        child: Column(
          children: <Widget>[
    GestureDetector(
    onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) =>  MobileNtfScreen()));
    },
    child: const Text(
    "verifying by mobile ",
    style: TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold),
    ),
    ),


          ],
        ),
        )
      ],
    );
  }
  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
  }

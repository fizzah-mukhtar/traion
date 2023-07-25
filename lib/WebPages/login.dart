import 'dart:html';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:traion/ColorThemes/appColors.dart';
import 'package:traion/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:traion/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final resetPassEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    String _inputValue = '';

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      resetPassEmailController.dispose();
      super.dispose();
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(

  
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [
            //     blueGradient,
            //     pinkGradient
            //     ,blueGradient
            //   ],
            // )
          


         
              ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
         
        ),
        Scaffold(
          backgroundColor: mainBackgroundColor,
          
          body: Container(
              decoration: BoxDecoration(
                
          //   gradient: LinearGradient(

          //   begin: Alignment.topRight,
          // end: Alignment.bottomCenter,
          // stops: [
          //       0.1,
          //       0.6,
          //       1.0],
          //     colors: [
          //                       Color.fromARGB(255, 5, 30, 50),

          //        Color.fromARGB(255, 123, 7, 98),
          //                       Color.fromARGB(255, 5, 30, 50),

                
          //     ],
          //               // stops: [0.9, 0.1],

          //   )
          ),  
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage('images/trAIon logo.png'),
                      height: (currentHeight * 15) / 100,
                      width: (currentWidth * 15) / 100,
                    ),
                    SizedBox(
                      width: (currentWidth * 40) / 100,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Image(
                            width: (currentWidth * 50) / 100,
                            height: (currentHeight * 80) / 100,
                            image: AssetImage(
                              'images/trAIon logo.png',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: currentWidth * 10 / 100,
                        ),
                        Container(
                          width: (currentWidth * 30) / 100,
                          height: (currentHeight * 70) / 100,
                          // padding: EdgeInsets.fromLTRB(30, 30, 0, 30),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: boxesBorderColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: secondaryBackgroundColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 00.0),
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.lora(
                                    color: mainTextColor,
                                    fontSize: 50,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10, right: 10, bottom: 10),
                                child: SizedBox(
                                  width: 278,
                                  height: 35,
                                  child: TextField(
                                    style: TextStyle(color: mainTextColor),
                                    controller: emailController,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: mainTextColor, fontSize: 13),
                                      hintText: "Email",
                                      fillColor: mainBackgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10, right: 10, bottom: 10),
                                child: SizedBox(
                                  width: 278,
                                  height: 35,
                                  child: TextField(
                                    style: TextStyle(color: mainTextColor),
                                    controller: passwordController,
                                    textAlign: TextAlign.start,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: mainTextColor, fontSize: 13),
                                      hintText: "Password",
                                      fillColor: mainBackgroundColor,
                                    ),
                                  ),
                                ),
                              ),
          
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(left: 10, right: 10),
                              //   child: SizedBox(
                              //     width: 278,
                              //     height: 35,
                              //     child: Passwordfield(),
                              //     // padding: const EdgeInsets.all(10),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 165.0, bottom: 10),
                                child: SizedBox(
                                  child: TextButton(
                                      // style: TextButton.styleFrom(
                                      //     // backgroundColor: mainBackgroundColor,
                                      //     textStyle: TextStyle(color: mainTextColor)),
                                      onPressed: () => {
                                            showDialog(
                                              barrierColor: boxesBorderColor,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Enter Your Email'),
                                                  content: TextFormField(
                                                    controller:
                                                        resetPassEmailController,
                                                    cursorColor: mainTextColor,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    decoration: InputDecoration(
                                                      hintText: 'Email',
                                                    ),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (email) => email !=
                                                                null &&
                                                            !EmailValidator
                                                                .validate(email)
                                                        ? 'Enter a valid email'
                                                        : null,
                                                  ),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  mainButtonsColor),
                                                      child: Text(
                                                          style: TextStyle(
                                                              color:
                                                                  mainTextColor),
                                                          'Reset Password'),
                                                      onPressed: () {
                                                        // Do something with the input value
                                                        // print('Input value: $_inputValue');
                                                        verifyEmail();
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  mainButtonsColor),
                                                      child: Text(
                                                          style: TextStyle(
                                                              color:
                                                                  mainTextColor),
                                                          'Cancel'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          },
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                            color: mainTextColor, fontSize: 12),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: SizedBox(
                                  width: 278,
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainButtonsColor),
                                    onPressed: logIn,
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 20, color: buttonsTextColors),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 165.0, bottom: 10),
                                child: SizedBox(
                                  child: TextButton(
                                      // style: TextButton.styleFrom(
                                      //     // backgroundColor: mainBackgroundColor,
                                      //     textStyle: TextStyle(color: mainTextColor)),
                                      onPressed: () => {
                                            Navigator.pushNamed(
                                                context, '/Signup')
                                          },
                                      child: Text(
                                        "New Here? Signup",
                                        style: TextStyle(
                                            color: mainTextColor, fontSize: 12),
                                      )),
                                ),
                              ),
                              Text(
                                '- - - - - - - - - - - - - - - - OR - - - - - - - - - - - - - - - -',
                                style:
                                    TextStyle(fontSize: 15, color: mainTextColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: SizedBox(
                                  width: 278,
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainButtonsColor),
                                    onPressed: () => {
                                      // googleLogin(),
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Image(
                                              image: AssetImage(
                                                  'images/google icon.png')),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30.0),
                                          child: Text(
                                            'Login with Google',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: buttonsTextColors),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 0.0, top: 15),
                                child: SizedBox(
                                  width: 278,
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainButtonsColor),
                                    onPressed: () => {
                                      Navigator.pushNamed(
                                          context, '/TraionStudio'),
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Image(
                                              image: AssetImage(
                                                  'images/fb icon.png')),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30.0),
                                          child: Text(
                                            'Login with Facebook',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: buttonsTextColors),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future logIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      await showDialog(
          barrierColor: boxesBorderColor,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: mainBackgroundColor,
              title: Text(
                  style: TextStyle(color: mainTextColor),
                  (e.message.toString())),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainButtonsColor),
                  child: Text(style: TextStyle(color: mainTextColor), 'OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
    Navigator.of(context).pop();
  }

  Future signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // await FirebaseAuth.instance.signInWithCredential(credential)
  }

  Future verifyEmail() async {
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetPassEmailController.text.trim());
      Navigator.of(context).pop();
      await showDialog(
          barrierColor: boxesBorderColor,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: mainBackgroundColor,
              title: Text(
                  style: TextStyle(color: mainTextColor),
                  ("Password Reset Email Sent")),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainButtonsColor),
                  child: Text(style: TextStyle(color: mainTextColor), 'OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e);
      await showDialog(
          barrierColor: boxesBorderColor,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: mainBackgroundColor,
              title: Text(
                  style: TextStyle(color: mainTextColor),
                  (e.message.toString())),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainButtonsColor),
                  child: Text(style: TextStyle(color: mainTextColor), 'OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      Navigator.of(context).pop();
    }
  }
  //  FlutterLogin(
  //                             onSignup: (_) => Future.value(''),
  //                             onLogin: (_) => Future.value(''),
  //                             onRecoverPassword: (_) => Future.value(''),
  //                           theme:LoginTheme(primaryColor:Theme.of(context).primaryColor,),
  //                           ),

  void _showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Your Email'),
          content: TextFormField(
            onChanged: (value) {
              // _inputValue = value;
            },
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: mainButtonsColor),
              child: Text('Send Code'),
              onPressed: () {
                // Do something with the input value
                // print('Input value: $_inputValue');
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: mainButtonsColor),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Passwordfield extends StatefulWidget {
  const Passwordfield({super.key});

  @override
  State<Passwordfield> createState() => _PasswordfieldState();
}

class _PasswordfieldState extends State<Passwordfield> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) => TextField(
        // controller :passwordController,

        obscureText: isHidden,
        textAlign: TextAlign.start,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: isHidden
                ? Icon(
                    Icons.visibility_off,
                    color: mainTextColor,
                  )
                : Icon(Icons.visibility, color: mainTextColor),
            onPressed: togglePasswordVisibility,
          ),

          alignLabelWithHint: false,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          // filled: true,
          hintStyle: TextStyle(color: mainTextColor, fontSize: 13),
          hintText: "Password",
          fillColor: mainBackgroundColor,
        ),
      );
  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
//  final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;
//   GoogleSignInAccount get user => _user!;
//   Future googleLogin() async {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) return;
//     _user = googleUser;
//     final googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//     await FirebaseAuth.instance.signInWithCredential(credential);
//   }

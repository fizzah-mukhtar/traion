import 'dart:html';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:traion/ColorThemes/appColors.dart';
import 'package:traion/main.dart';

import '../classes/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
            
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
         
        ),
        Scaffold(
          backgroundColor: mainBackgroundColor,
          body: Container(
            //  decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [
            //     blueGradient,
            //     pinkGradient
            //     ,blueGradient
            //   ],
            // ),
            //  ),
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
                          height: (currentHeight * 75) / 100,
                          // padding: EdgeInsets.fromLTRB(30, 30, 0, 30),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: boxesBorderColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: secondaryBackgroundColor,
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 00.0),
                                  child: Text(
                                    "Sign up",
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
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: mainTextColor, fontSize: 13),
                                        hintText: "Username",
                                        fillColor: mainBackgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: SizedBox(
                                    width: 278,
                                    height: 35,
                                    child: TextFormField(
                                      style: TextStyle(color: mainTextColor),
                                      controller: emailController,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
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
                                      // autovalidateMode:
                                      //     AutovalidateMode.onUserInteraction,
                                      // validator: (email) => email != null &&
                                      //         !EmailValidator.validate(email)
                                      //     ? 'Enter a valid email'
                                      //     : null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: SizedBox(
                                    width: 278,
                                    height: 35,
                                    child: TextFormField(
                                      style: TextStyle(color: mainTextColor),
                                      controller: passwordController,
                                      obscureText: true,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
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
                                      // autovalidateMode:
                                      //     AutovalidateMode.onUserInteraction,
                                      // validator: (value) =>
                                      //     value != null && value.length < 6
                                      //         ? 'Enter min. 6 characters'
                                      //         : null,
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 10, right: 10, bottom: 10),
                                //   child: SizedBox(
                                //     width: 278,
                                //     height: 35,
                                //     child: Passwordfield(),
                                //     // padding: const EdgeInsets.all(10),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: SizedBox(
                                    width: 278,
                                    height: 35,
                                    child: ConfirmPasswordfield(),
                                    // padding: const EdgeInsets.all(10),
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
                                      onPressed: signUp,
                                      child: Text(
                                        'Signup',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: buttonsTextColors),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 130.0, bottom: 3),
                                  child: SizedBox(
                                    child: TextButton(
                                        // style: TextButton.styleFrom(
                                        //     // backgroundColor: mainBackgroundColor,
                                        //     textStyle: TextStyle(color: mainTextColor)),
                                        onPressed: () => {
                                              Navigator.pushNamed(
                                                  context, '/Login'),
                                            },
                                        child: Text(
                                          "Alaready Registered? Login",
                                          style: TextStyle(
                                              color: mainTextColor, fontSize: 12),
                                        )),
                                  ),
                                ),
                                Text(
                                  '- - - - - - - - - - - - - - - - OR - - - - - - - - - - - - - - - -',
                                  style: TextStyle(
                                    color: mainTextColor,
                                    fontSize: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: SizedBox(
                                    width: 278,
                                    height: 35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainButtonsColor),
                                      onPressed: () => {},
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
                                              'Signup with Google',
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
                                      onPressed: () => {},
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
                                              'Signup with Facebook',
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

  Future signUp() async {
    // final isValid = formKey.currentState!.validate();
    // if (!isValid)
    //   return;
    // else
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      // showDialog(e.message);
    }
    Navigator.of(context).pop();
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
  Widget build(BuildContext context) => TextFormField(
        style: TextStyle(color: mainTextColor),
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

class ConfirmPasswordfield extends StatefulWidget {
  const ConfirmPasswordfield({super.key});

  @override
  State<ConfirmPasswordfield> createState() => _ConfirmPasswordfieldState();
}

class _ConfirmPasswordfieldState extends State<ConfirmPasswordfield> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) => TextFormField(
        style: TextStyle(color: mainTextColor),
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
          hintText: "Confirm Password",
          fillColor: mainBackgroundColor,
        ),
      );
  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}

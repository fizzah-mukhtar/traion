import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ColorThemes/appColors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: secondaryBackgroundColor,
        title: Container(
          height: 100,
          width: 110,
          child: Image(
                        image: AssetImage('images/trAIon logo.png'),
                       
                      ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: secondaryBackgroundColor,
                ),
                onPressed: () => {
                      // Navigator.pushNamed(context, '/Home'),
                    },
                icon: Icon(
                  Icons.home,
                  color: mainTextColor,
                ),
                label: Text(
                  'Home',
                  style: TextStyle(color: mainTextColor),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: secondaryBackgroundColor,
                ),
                onPressed: () => {
                      Navigator.pushNamed(context, '/TraionStudio'),
                    },
                icon: Icon(
                  Icons.remove_from_queue_sharp,
                  color: mainTextColor,
                ),
                label: Text(
                  'trAIon Studio',
                  style: TextStyle(color: mainTextColor),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: TextButton.icon(
              onPressed: () => {},
              icon: Icon(
                Icons.person,
                color: mainTextColor,
              ),
              label: Text('Profile', style: TextStyle(color: mainTextColor)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 30),
            child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: secondaryBackgroundColor,
                ),
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(
                  Icons.logout_sharp,
                  color: mainTextColor,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: mainTextColor),
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(bottom: 5.0),
                            //       child: Text(
                            //         'See it,',
                            //         style: GoogleFonts.lora(
                            //           color: mainTextColor,
                            //           fontSize: 50,
                            //         ),
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(bottom: 5.0),
                            //       child: Text(
                            //         ' Love it,',
                            //         style: GoogleFonts.lora(
                            //           color: mainTextColor,
                            //           fontSize: 50,
                            //         ),
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(bottom: 5.0),
                            //       child: Text(
                            //         ' Wear it,',
                            //         style: GoogleFonts.lora(
                            //           color: mainTextColor,
                            //           fontSize: 50,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    'Revolutionize the Way You Shop Through AI Based',
                                    style: GoogleFonts.lora(
                                      color: mainTextColor,
                                      fontSize: 25,
                                    ),
                                  ),
                                  
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    ' AI ',
                                    style: GoogleFonts.lora(
                                      color: mainTextColor,
                                      fontSize: 50,
                                    ),
                                  ),
                                  
                                ),
                                 Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    'Based',
                                    style: GoogleFonts.lora(
                                      color: mainTextColor,
                                      fontSize: 50,
                                    ),
                                  ),
                                  
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                'Virtual trAIon Technology!',
                                style: GoogleFonts.lora(
                                  color: mainTextColor,
                                  fontSize: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text(
                                'Under Construction',
                                style: GoogleFonts.lora(
                                  color: mainTextColor,
                                  fontSize: 70,
                                ),
                              ),
                            )
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 0.0),
                            //   child: SizedBox(
                            //     width: 278,
                            //     height: 35,
                            //     child: ElevatedButton(
                            //       style: ElevatedButton.styleFrom(
                            //           backgroundColor: mainButtonsColor),
                            //       onPressed: () => {},
                            //       child: Text(
                            //         'Get Started >',
                            //         style: TextStyle(
                            //             fontSize: 20, color: mainTextColor),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                          // padding: const EdgeInsets.all(8.0),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget appBarOptions(Icon? icon, Text? text, VoidCallback? onTap) {
  return TextButton.icon(onPressed: onTap, icon: icon!, label: text!);
}

TextStyle textButtonTextStyle() {
  return TextStyle(
    color: mainBackgroundColor,
  );
}

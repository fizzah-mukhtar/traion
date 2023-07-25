import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traion/CustomWidgets/emailVerification.dart';
import 'package:traion/WebPages/home.dart';
import 'package:traion/WebPages/login.dart';
import 'package:traion/WebPages/traionStudio.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:traion/entry.dart';

import 'WebPages/signup.dart';
import 'classes/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDokI4JfC_d6fSbjeEjb7x-ab9l8vna_jc",
    projectId: "traion-9e904",
    messagingSenderId: "843055711057",
    appId: "1:843055711057:web:bd97cfdd28af24a3a34970",
  ));

  // String initialRoute1='';
//   runApp( StreamBuilder<User>(
//     stream: FirebaseAuth.instance.authStateChanges(),

//     builder: (context, snapshot)

//     {
//       if(snapshot.hasData)
//       {
// return MaterialApp(
//               initialRoute:'/Home', //Initial route or page for our web
//               routes: {
//                 '/TraionStudio': (Context) => const TraionStudio(),
//                 '/Signup': (context) => const SignUpPage(),
//                 '/Login': (context) => const LoginPage(),
//                 '/Home': (context) => const HomePage(),
//               },
//             );
//       }
//       else{
// return MaterialApp(
//               initialRoute:'/Login', //Initial route or page for our web
//               routes: {
//                 '/TraionStudio': (Context) => const TraionStudio(),
//                 '/Signup': (context) => const SignUpPage(),
//                 '/Login': (context) => const LoginPage(),
//                 '/Home': (context) => const HomePage(),
//               },
//             );
//       }

//     }
//   ),);
  final navigatorKey = GlobalKey<NavigatorState>();
// ScaffoldMessengerKey:Utils.messengerKey;
  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong!'),
          );
        } else if (snapshot.hasData) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            initialRoute: '/Home', //Initial route or page for our web
            routes: {
              '/TraionStudio': (Context) => const TraionStudio(),
              '/Signup': (context) => const SignUpPage(),
              '/Login': (context) => const LoginPage(),
              '/Home': (context) => const emailVerificationPage(),
              // '/VerifyEmail': (context) => const emailVerificationPage(),
            },
          );
        } else {
          return MaterialApp(
            initialRoute: '/Login', //Initial route or page for our web
            routes: {
              '/TraionStudio': (Context) => const TraionStudio(),
              '/Signup': (context) => const SignUpPage(),
              '/Login': (context) => const LoginPage(),
              '/Home': (context) => const HomePage(),
            },
          );
        }
      },
    ),
  );
}

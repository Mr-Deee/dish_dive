import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'Pages/SignUp.dart';
import 'Pages/Welcomepage.dart';
import 'Pages/homepage.dart';
import 'Pages/login.dart';
import 'firebase_options.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
DatabaseReference Users = FirebaseDatabase.instance.ref().child("Users");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DishDive',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        useMaterial3: true,
      ),
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? '/WelcomePage'
            : '/Homepage',
        routes: {

          "/SignUP": (context) => Signup(),
          "/WelcomePage": (context) => Welcomepage(),
          "/SignIn": (context) => LoginPage(),
          "/Homepage": (context) => homepage(),
          //    "/addproduct":(context)=>addproduct()
        }
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),

      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


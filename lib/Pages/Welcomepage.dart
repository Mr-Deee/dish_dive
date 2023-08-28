import 'package:dish_dive/Pages/SignUp.dart';
import 'package:dish_dive/Pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({Key? key}) : super(key: key);

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(
            image: AssetImage('assets/images/onboardingimage.jpg'), // Path to your image asset
            fit: BoxFit.cover, // Adjust the image size as needed
          ),
        ),

        child: Column(
          children: [
          Padding(
            padding: EdgeInsets.only(top:158.0),
            child: Center(child:

            RichText(
            text: TextSpan(
            style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: 'Dish',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: 'Dive',
                  style: TextStyle(color: Colors.redAccent),
                ),

         ]))


         ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Text("Making cooking a single step easier",style: TextStyle( fontSize: 20,fontWeight: FontWeight.w700),),
          ),



          SizedBox(height: 220,),

          GestureDetector(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Signup()),
                      (Route<dynamic> route) => true);
            },
            child: Container(
              width: 170,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20),

              ),
                child: Center(child: Text("SignUP",style: TextStyle(fontSize: 20,color: Colors.white),))),
          ),
          SizedBox(height: 20,),

          GestureDetector(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => true);
            },
            child: Container(
              width: 170,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20),

              ),
                child: Center(child: Text("Login",style: TextStyle(fontSize: 20,color: Colors.white),))),
          )

        ],),
      ),
    );
  }
}

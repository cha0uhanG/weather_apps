import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/presentation/auth/sign_in_screen.dart';
import 'package:weather_app/presentation/weather/location_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const page = "Splash_screen" ;


  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      checkuser();
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color:Colors.black ,strokeWidth: 10.0),
          SizedBox(height: 10,),
          Center(child: Text("Loading",style: TextStyle(fontWeight: FontWeight.w900,fontSize:20 ),))
        ],
      ),
    );
  }
  void checkuser(){
    User? user = FirebaseAuth.instance.currentUser;    // here we are checking wheter user is logged in or not
    if (user != null) {
      Navigator.pushReplacementNamed(context,LocationPage.page);
    } else {
      Navigator.pushReplacementNamed(context, SigninPage.page);

    }


  }
}









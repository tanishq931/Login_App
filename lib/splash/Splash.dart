import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/auth/login.dart';
import 'package:login_app/auth/logincheck.dart';
import 'package:login_app/database/PostData.dart';
import 'package:login_app/database/ShowData.dart';
import 'package:login_app/mainfiles/post.dart';
import 'package:login_app/textstyles/textstyle1.dart';



class Splash extends StatefulWidget{


  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
      Logcheck().isLogin(context)?
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowDB()))
      :
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff0f0063),
        child: Center(child: Text('Flutter Project',style: textstyle(),
      ))),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Logcheck {

  bool isLogin(BuildContext context){
    final auth =FirebaseAuth.instance;
    final user =auth.currentUser;
    if(user!=null){
      return true;
    }
    else{
      return false;
    }

  }
}
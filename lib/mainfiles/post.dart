import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/auth/login.dart';
import 'package:login_app/utils/utils.dart';

class Images extends StatefulWidget {

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  FirebaseAuth auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Posts Here'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/rdr1.png'),
              IconButton(onPressed: (){
                auth.signOut().then((value) => {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())).
                  onError((error, stackTrace) => {
                    Utils().toastmsg(error.toString())
                  })
                });
              }, icon: Icon(Icons.logout_outlined))
            ],
          ),

        ),
      ),
    );
  }
}

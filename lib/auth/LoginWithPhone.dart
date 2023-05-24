import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/buttons/roundbutton.dart';
import 'package:login_app/database/ShowData.dart';
import 'package:login_app/mainfiles/post.dart';
import 'package:login_app/utils/utils.dart';

class Loginwithphone extends StatefulWidget {
  const Loginwithphone({Key? key}) : super(key: key);

  @override
  State<Loginwithphone> createState() => _LoginwithphoneState();
}

class _LoginwithphoneState extends State<Loginwithphone> {
  String verify = "";
  int? id;
  String code="+91";
  bool loading = false,sent=false;
  var key = GlobalKey<FormState>();
  var auth = FirebaseAuth.instance;
  var phone = TextEditingController();
  var otp = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff1CB5E0),
      appBar: AppBar(
        title: Text("Login with Phone"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "+91 9000000000",
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Phone Number";
                        }
                      },

                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: otp,
                      decoration: const InputDecoration(
                        hintText: 'Enter OTP',
                        prefixIcon: Icon(Icons.lock_clock),
                      ),


                    ),
                  ],
                )
            ),
            SizedBox(height: 30,),
            Container(
              child: sent? InkWell(
                  child:roundbutton(text: 'Login', loading: loading),
                  onTap:(){
                    final credential = PhoneAuthProvider.credential(
                        verificationId: verify,
                        smsCode: otp.text.toString(),
                    );
                    try{
                      auth.signInWithCredential(credential)
                          .then((value){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context)=> ShowDB()));
                          }).onError((error, stackTrace) {
                            Utils().toastmsg('otp galat he');});


                    }catch(e){
                      Utils().toastmsg(e.toString());

                    }
                  }
              )
                  :InkWell(
                  child: roundbutton(text: 'Get OTP', loading: loading),
                  onTap: () {

                    if (key.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      auth.verifyPhoneNumber(verificationCompleted: (_) {
                        setState(() {
                          loading = false;
                        });
                      },

                          phoneNumber:"${code+phone.text.toString()}",

                          verificationFailed: (e) {
                            setState(() {
                              loading=false;
                            });
                            Utils().toastmsg(e.toString());

                          },
                          codeSent: (String verificationId,int? token) {
                            setState(() {
                              sent=true;
                            });

                            setState(() {
                              loading=false;
                            });
                            verify = verificationId;


                          },
                          codeAutoRetrievalTimeout: (e) {
                            Utils().toastmsg(e.toString());
                            setState(() {
                              loading = false;
                            });
                          });
                    }
                  }),
            )






          ],
        ),
      ),
    );
  }
}

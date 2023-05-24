


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/auth/LoginWithPhone.dart';
import 'package:login_app/auth/signup.dart';
import 'package:login_app/auth/textfield.dart';
import 'package:login_app/buttons/roundbutton.dart';
import 'package:login_app/database/ShowData.dart';
import 'package:login_app/mainfiles/post.dart';
import 'package:login_app/textstyles/textstyle1.dart';
import 'package:login_app/utils/utils.dart';


class Login extends StatefulWidget {


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading= false;
  var logout=false;
  FirebaseAuth auth = FirebaseAuth.instance;
  var key = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login Page'), centerTitle: true,
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Form(
            key: key,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(11),
                  child: TextFormField(controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter email";
                      }
                    },
                    decoration: decor(icon: Icon(Icons.email,color: Colors.blueGrey,),hint: "Enter email")
                  ),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(11),
                  child: TextFormField(controller: pass,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      }
                    },

                    decoration: decor(icon: Icon(Icons.password_rounded,color: Colors.blueGrey,),hint: "Enter Password")

                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
            InkWell(onTap: () {
           setState((){
             load();
           });

          },
            child: roundbutton(text: "Login", loading: loading)),
            Padding(
        padding: const EdgeInsets.all(11.0),
        child: Row(children: [
          Text("Don't have any account?"),
          TextButton(onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          }, child: Text('SignUp', style: TextStyle(color: Colors.blue),))
        ],),
      ),
            InkWell(child: roundbutton(text: "Login with Phone"),onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>Loginwithphone()));
            },)
     ],),)
    );
  }
  void load(){


    if (key.currentState!.validate()) {
      loading=true;
      auth.signInWithEmailAndPassword(email: email.text,
          password: pass.text)
          .then((value) async {
        final snackbar = SnackBar(content: Text('Successfull Login'),
          action: SnackBarAction(
            label: 'Logout',
            onPressed: (){
              setState(() {
              auth.signOut();
               logout=true;

              });

            },

          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
       loading=false;

      if(logout==false){await Future.delayed(Duration(seconds: 5));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ShowDB()));}})
          .onError((error, stackTrace) {
        loading=false;
        Utils().toastmsg(error.toString());});
    }

}

}






import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/auth/login.dart';
import 'package:login_app/auth/textfield.dart';
import 'package:login_app/buttons/roundbutton.dart';
import 'package:login_app/utils/utils.dart';



class SignUp extends StatefulWidget{


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth  _auth = FirebaseAuth.instance;

  var key = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass  = TextEditingController();
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          title: const Text('SignUp Page'),centerTitle: true,
        ),
        body:Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,children: [
            Form(
              key: key,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(11),
                    child: TextFormField(controller: email,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter email";
                        }
                        },
                      keyboardType: TextInputType.emailAddress,
                      decoration: decor(icon: Icon(Icons.email_outlined,color: Colors.blueGrey,),hint: "Enter email"),

                    ),
                  ),
                  const SizedBox(height: 5,),
                  Padding(
              padding: const EdgeInsets.all(11),
              child: TextFormField(controller: pass,
                obscureText: true,
                validator: (value){
                   if(value!.isEmpty){
                     return "Enter Password";
                   }
                },


                decoration: decor(icon: Icon(Icons.password_outlined,color: Colors.blueGrey,),hint: "Enter Password")

              ),
            ),
                ],
              ),

            ),
            const SizedBox(height: 40),
            InkWell(child: roundbutton(text: "SignUp",loading: loading),onTap: (){
              setState(() {

                if(key.currentState!.validate()){
                    loading=true;
                  _auth.createUserWithEmailAndPassword(
                      email: email.text.toString(),
                      password: pass.text).then((value){
                    loading=false;
                    Utils().toastmsg("Successfully Signed Up");
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                  }).onError((error, stackTrace) {
                    loading=false;
                    Utils().toastmsg(error.toString());

                  });
                }
              });
            },),

            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Row(children: [
                Text("Already have an account"),
                TextButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
                }, child: Text('Login',style: TextStyle(color: Colors.blue),))
              ],),
            )


          ],),
        )
    );
  }
}

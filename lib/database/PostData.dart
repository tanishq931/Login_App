import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/buttons/roundbutton.dart';
import 'package:login_app/utils/utils.dart';

class PostData extends StatefulWidget {

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final key = GlobalKey<FormState>();
  final text =TextEditingController();

  final ref = FirebaseDatabase.instance.ref('Post');
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DATABASE'),),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(child: TextFormField(
              controller: text,
              maxLines: 4,
              decoration: const InputDecoration(
                  hintText: 'Enter your data',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 4
                      )
                  )
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "Enter Text";
                }
              },

            )),
            const SizedBox(height: 20),
            InkWell(child: roundbutton(text: "Post"),onTap: (){
              String id =DateTime.now().millisecondsSinceEpoch.toString();
              ref.child(id).set({
                'title':text.text.toString(),
                'id' : id
              });


              Utils().toastmsg('Posted');
            },),

          ],
        ),
      ),
    );
  }
}

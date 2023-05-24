import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/auth/login.dart';
import 'package:login_app/buttons/roundbutton.dart';
import 'package:login_app/database/PostData.dart';
import 'package:login_app/utils/utils.dart';

class ShowDB extends StatefulWidget {

  @override
  State<ShowDB> createState() => _ShowDBState();
}

class _ShowDBState extends State<ShowDB> {
  final key = GlobalKey<FormState>();
  final search =TextEditingController();
  final edit=TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Post');
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:const Text('DATABASE Show'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value) => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())).
              onError((error, stackTrace) => {
                Utils().toastmsg(error.toString())
              })
            });
          }, icon: Icon(Icons.logout_outlined))
        ],),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(onPressed: (){
           Navigator.push(context,MaterialPageRoute(builder: (context)=>PostData()));
        },
        child:const Icon(Icons.add),
        ),
        body:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
           children: [
                 TextField(
                        controller: search,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.blue,
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.red,
                            )
                          ),
                          hintText: 'Search text',
                        ),
                        onChanged: (_){
                          setState(() {

                          });
                        },
                      ),
                      const SizedBox(height: 10,),
                      Expanded(
                        child: FirebaseAnimatedList(
                            query: ref,

                            itemBuilder: (context,snapshot,animation,index){

                              String title = snapshot.child('title').value.toString();
                              String id = snapshot.child('id').value.toString();

                             if(search.text.toString().isEmpty){
                              return ListTile(
                                title: Text(snapshot.child('title').value.toString()),
                                // subtitle: Text(snapshot.child('id').value.toString()),
                                trailing: PopupMenuButton(
                                  icon: Icon(Icons.more_vert_rounded),
                                  itemBuilder: (context)=>[
                                       edits(id),del(id)
                                          ]
                                       ),
                                     );
                                  }
                             else if(title.toLowerCase().contains(search.text.toString().toLowerCase())){
                                 return ListTile(
                                 title: Text(snapshot.child('title').value.toString()),
                                 // subtitle: Text(snapshot.child('id').value.toString()),
                                   trailing: PopupMenuButton(
                                       icon: Icon(Icons.more_vert_rounded),
                                       itemBuilder: (context)=>[
                                       edits(id),
                                         del(id)
                                       ]
                                   ),
                                );
                             }
                             else
                               {
                                return Container();
                               }
                             }



                      ),
                      ),
          ],

          ),
        )




    );

  }
  PopupMenuItem edits(String id) {
    return  PopupMenuItem(child: ListTile(
      leading: Icon(Icons.edit),
      title: Text('Edit'),
      onTap: (){
        Navigator.pop(context);
         showDial(id);
      },
    ));

  }
  PopupMenuItem del(String id){
    return  PopupMenuItem(child: ListTile(
      leading: Icon(Icons.delete),
      title: Text('Delete'),
      onTap: (){

        Navigator.pop(context);
        deldial(id);
      } ,
    ) );

  }
   Future<void> showDial(String id){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Edit'),
        content: TextField(
          controller: edit,

        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel')),
          TextButton(onPressed: (){
            ref.child(id).update({
              'title': edit.text
            });
            Navigator.pop(context);
          }, child: Text('Update'))
        ],
      );
    });
   }
    Future<void> deldial(String id){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Are you sure you want to delete"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel')),
              TextButton(onPressed: (){
                ref.child(id).remove();
                Navigator.pop(context);
              }, child: Text('Delete')),
            ],
        );
      }
    );
   }


}

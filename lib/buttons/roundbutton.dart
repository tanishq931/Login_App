import 'package:flutter/material.dart';

import 'package:login_app/textstyles/textstyle1.dart';
Container roundbutton({
  required String text,
  Color color=Colors.deepPurple,

  bool loading=false}){

  return Container(

  width: 200,
    height: 50,

    child: Center(
        child: loading
            ?CircularProgressIndicator(strokeWidth: 5,color: Colors.white,)
            :Text("$text",style: textStyle2(size: 30),)),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20)
    ),

  );


}

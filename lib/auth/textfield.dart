import 'package:flutter/material.dart';

InputDecoration decor({required Icon icon,String hint="Enter Text"}){
  return InputDecoration(
      prefixIcon: icon,
      hintText: hint,
      focusedBorder: const OutlineInputBorder(

          borderSide: BorderSide(
              color: Color(0xff007fff),
              width: 3
          )
      ),

      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff72a0c1),

          )

      )
  );


}
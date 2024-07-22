import 'package:flutter/material.dart';

Widget myHeader (String title) {
  return Column(
    children: [
      SizedBox(height: 20,),
      Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 23),
      ),
      Divider(color: Colors.lightGreen, indent: 180, endIndent: 180, thickness: 2,),
    ],
  );
}
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
            child: Text(
          "Sign In",
          style: TextStyle(color: Colors.white),
        )));
  }
}

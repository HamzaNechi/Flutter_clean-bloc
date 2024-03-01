import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SnackbarMessage{


  void showSuccessSnackBar({required String message, required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message, style: const TextStyle(color: Colors.white),),
                backgroundColor: Colors.green,
                )
              );
  }



  void showErrorSnackBar({required String message, required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message, style: const TextStyle(color: Colors.white),),
                backgroundColor: Colors.redAccent,
                )
              );
  }
}
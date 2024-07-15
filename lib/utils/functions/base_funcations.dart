import 'package:flutter/material.dart';

import '../enums/enums.dart';


   ThemeData getTheme({required BuildContext context}) {
     return Theme.of(context);
   }


void showCustomSnackBar(
    {required BuildContext context,required String message,required SnackBarType type}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          type == SnackBarType.success ? Icons.check_circle : Icons.error,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(message, style: const TextStyle(color: Colors.white))),
      ],
    ),
    backgroundColor: type == SnackBarType.success ? Colors.green : Colors.red,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}




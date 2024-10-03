import 'package:flutter/material.dart';

class AppUtils {
  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }

  static showMyDialog(
    String message,
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(message.toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}
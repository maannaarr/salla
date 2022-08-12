import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cache_helper.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget buildTextFormField(
    {final Widget? suffixIcon,
    required final bool obsecureText,
    required final TextEditingController controller,
    required final Widget label,
    required final Widget prefixIcon,
    required final String? Function(String?) functionValidator,
    required final TextInputType keyboardType}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      obscureText: obsecureText,
      keyboardType: keyboardType,
      validator: functionValidator,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Color(0xFFf5f5f5),
          suffixIcon: suffixIcon,
          label: label,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    ),
  );
}

Future<bool?> myFlutterToast(String text, ToastStates states) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseColor(states),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { ERROR, SUCCESS, WARNING }

Color chooseColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.SUCCESS:
      color = Colors.green;

      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

  String token ='' ;

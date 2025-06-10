import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.cyan,
  required String title,
  required VoidCallback onPressed,
  double elevate = 5.0,
}) => Container(
  width: width,
  padding: EdgeInsets.all(10.0),
  child: Material(
    elevation: elevate,

    color: background,
    borderRadius: BorderRadius.circular(30.0),
    child: MaterialButton(
      hoverColor: Colors.grey,
      onPressed: onPressed,

      // color: Colors.blue,
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 15.0)),
    ),
  ),
);

Widget defaultTextFormField({
  required String label,
  Color txtColore = Colors.grey,
  Function? Validate,
  Function? onChanged,
  Widget? suffixIcon,
  Widget? prefixIcon,
}) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: TextFormField(
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      label: Text(label, style: TextStyle(color: txtColore)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      focusedBorder: OutlineInputBorder(
        // borderSide: BorderSide(
        //   color: Colors.black26,
        // ),
      ),
    ),
    validator: (value) {
      return value;
    },
    onChanged: (value) {
      print(value);
    },
  ),
);

Widget txtButtun({
  required String txt,
  required String txtBtn,
  required VoidCallback onPressed,
  FontWeight fontWeight=FontWeight.bold,
}) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(txt, style: TextStyle(fontWeight: FontWeight.bold)),
    TextButton(onPressed: onPressed, child: Text(txtBtn,style: TextStyle(fontWeight: fontWeight),)),
  ],
);


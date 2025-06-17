import 'package:flutter/material.dart';

Widget DefaultButton({
  double width = double.infinity,
  Color background = Colors.cyan,
  required String title,
  required VoidCallback onPressed,
  double elevate = 5.0,
}) => Container(
  width: width,
  padding: EdgeInsets.all(10.0),
  child: MaterialButton(
    hoverColor: Colors.grey,
    onPressed: (){
      onPressed;
    },

    // color: Colors.blue,
    child: Text(title, style: TextStyle(color: Colors.white, fontSize: 15.0)),
  ),
);

Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.cyan,
  bool isUppercase=true,
  required VoidCallback function,
  required String text,

})=>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: background,
      ),

      child: MaterialButton(
        onPressed:function,
        child: Text(
          isUppercase?text.toUpperCase():text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );




Widget defaultFormField({
  TextEditingController? controller,
  required TextInputType type,
  required String? text,
  ValueChanged? onSubmite,
  ValueChanged? onChange,
  FormFieldValidator? validate,
  IconData? prefix,
  IconData? suffix,
  bool isPassword=false,
  VoidCallback? suffixPressed,


})=>TextFormField(
  controller: controller,
  obscureText: isPassword,
  keyboardType: type,
  onFieldSubmitted:onSubmite,
  onChanged: onChange,
  validator: validate,
  decoration: InputDecoration(
    labelText: text,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    suffixIcon:suffix!=null?
    IconButton(icon: Icon(suffix),
      onPressed: suffixPressed,):null,
    prefixIcon: Icon(prefix),
  ),
);


Widget txtButton({
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




























// Widget defaultTextFormField({
//   required String label,
//   Color txtColor = Colors.grey,
//   Function? validate,
//   Function? onChanged,
//   IconData? suffixIcon,
//   IconData? prefixIcon,
//   TextEditingController? controller,
//   Key? key,
//   TextInputType? type,
//   VoidCallback? suffixPressed,
//   bool isPassword=false,
// }) => Padding(
//   padding: const EdgeInsets.all(10.0),
//   child: TextFormField(
//     key:key ,
//     keyboardType: type,
//     decoration: InputDecoration(
//       suffixIcon: IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon)),
//       prefixIcon: Icon(prefixIcon),
//       label: Text(label, style: TextStyle(color: txtColor)),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
//       focusedBorder: OutlineInputBorder(
//         // borderSide: BorderSide(
//         //   color: Colors.black26,
//         // ),
//       ),
//     ),
//     validator: (value) {
//       return value;
//     },
//     onChanged: (value) {
//       print(value);
//     },
//   ),
// );
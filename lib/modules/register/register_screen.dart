import 'package:flutter/material.dart';
import 'package:qute_app/shared/components/components.dart';
// import 'package:sqflite/sqflite.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController? nameController;
  TextEditingController? passController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultTextFormField(
            controller: nameController,
              label: 'Name'
          ),
          SizedBox(height: 5.0),
          defaultTextFormField(
            controller: passController,
            label: 'Password',
            suffixIcon: Icon(Icons.remove_red_eye_rounded),
            prefixIcon: Icon(Icons.lock),
          ),
          defaultButton(title: 'Register', onPressed: () {
            // String name=nameController!.text;
            // String pass=nameController!.text;
            // insertData('''
            //   INSERT INTO users (user_name,password_hash) VALUES ($name,$pass)
            // ''');
          }),
          txtButton(
            txt:'You already have an account,',
            txtBtn:'Sign In',
            onPressed: () {
              Navigator.pushNamed(context, '/signIn');
            },
          ),
        ],
      ),
    );
  }
}

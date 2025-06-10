import 'package:flutter/material.dart';
import 'package:qute_app/modules/register/register_screen.dart';
import 'package:qute_app/shared/components/components.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultTextFormField(label: 'Name'),
          SizedBox(
            height: 7.0,
          ),
          defaultTextFormField(label: 'Password'),
          defaultButton(title: 'Sign In', onPressed: (){}),
          txtButtun(txt:'You do not have an account,', txtBtn:'Register',onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
          })
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qute_app/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultTextFormField(label: 'Name'),
          SizedBox(height: 5.0),
          defaultTextFormField(
            label: 'Password',
            suffixIcon: Icon(Icons.remove_red_eye_rounded),
            prefixIcon: Icon(Icons.lock),
          ),
          defaultButton(title: 'Register', onPressed: () {

          }),
          txtButtun(
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

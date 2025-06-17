import 'package:flutter/material.dart';
import '../../shared/components/components.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'i',
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Quotes',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.format_quote,
                color: Colors.cyan,
                size: 35.0,
              ),

              // Image(image: AssetImage('images/quote.png'),),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),

          defaultButton(
              text: 'Register',
              function: () {
                Navigator.pushNamed(context, '/register');
          }),
          defaultButton(text: 'Sign In', function: () {
              Navigator.pushNamed(context, '/signIn');
                     }),
        ],
      ),
    );
  }
}

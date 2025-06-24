import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SizedBox(
        width: double.infinity,
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
                Icons.format_quote_sharp,
                size: 100.0,
                color: Colors.white),
            SizedBox(
              height: 25.0,
            ),
            CircularProgressIndicator(
              color: Colors.white,
              // backgroundColor: Colors.cyan,

            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qute_app/modules/init/init_screen.dart';
import 'package:qute_app/modules/login/sign_in_screen.dart';

import 'layout/home_layout.dart';
import 'modules/register/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        splashFactory: InkSplash.splashFactory,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.cyan,
          // unselectedItemColor: Colors.grey,
        )

      ),
      initialRoute: '/homelayout',
      routes: {
        '/init':(context)=>InitScreen(),
        '/register':(context)=>RegisterScreen(),
        '/signIn':(context)=>SignInScreen(),
        '/homelayout':(context)=>HomeLayout(),
      },
      home:InitScreen(),
    );
  }
  
}
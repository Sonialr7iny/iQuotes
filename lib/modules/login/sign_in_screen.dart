import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qute_app/models/quote_model.dart';
import 'package:qute_app/modules/register/register_screen.dart';
import 'package:qute_app/quotes_sqflite.dart';
import 'package:qute_app/shared/components/components.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formState = GlobalKey();
  late TextEditingController nameController;
  late TextEditingController passController;
  bool isPassword = true;
  final QuotesDb quotesDb = QuotesDb();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LogIn ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 30.0),
                  defaultFormField(
                    type: TextInputType.text,
                    controller: nameController,
                    text: 'Name',
                    validate: (value) {
                      if (value.isEmpty) {
                        return "Name must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  defaultFormField(
                    type: TextInputType.visiblePassword,
                    controller: passController,
                    text: 'Password',
                    prefix: Icons.lock,
                    isPassword: isPassword,
                    suffix:
                        isPassword ? Icons.visibility : Icons.visibility_off,
                    suffixPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    validate: (value) {
                      if (value.isEmpty && value == null) {
                        return 'Password must not be empty ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.0),
                  defaultButton(
                    function: () async {
                      if (formState.currentState?.validate() ?? false) {
                        String enteredName = nameController.text;
                        String enteredPassword = passController.text;

                        try {
                          //1. Fetch user by userName
                         final UserModel? storedUser = await quotesDb
                              .getUserByUsername(enteredName);
                          if (storedUser == null) {
                            //User not found
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Invalid username or password'),
                                ),
                              );
                            }
                            return;
                          }
                            //2. User found ,now verify the password
                            // final UserModel user=storedUser!;
                            bool passwordMatches = BCrypt.checkpw(
                              enteredPassword,
                              storedUser.hashPassword,
                            ); // No '?' needed, directly access
                            if (passwordMatches) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Login successful!')),
                                );
                                Navigator.pushNamedAndRemoveUntil(context, '/homelayout', (Route<dynamic>route)=>false);
                              }
                            } else {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Invalid username or password.',
                                    ),
                                  ),
                                );
                              }
                            }
                         } catch (e) {
                          if (kDebugMode) {
                            print('Error during login :$e');
                          }
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'An error occurred.Please try again.',
                                ),
                              ),
                            );
                          }
                        }
                      }
                    },
                    text: 'Login',
                  ),
                  txtButton(
                    txt: 'You do not have an account,',
                    txtBtn: 'Register',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

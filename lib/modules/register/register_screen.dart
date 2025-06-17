import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qute_app/models/quote_model.dart';
import 'package:qute_app/quotes_sqflite.dart';

import '../../shared/components/components.dart';

// import 'package:sqflite/sqflite.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController? nameController;
  late TextEditingController? passController;
  final GlobalKey<FormState> formState = GlobalKey();
  bool isPassword = true;
  final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$',
  );
  final QuotesDb quotesDb = QuotesDb();
@override
void initState(){
  super.initState();
  nameController=TextEditingController();
  passController=TextEditingController();
}
@override
void dispose(){
  nameController?.dispose();
  passController?.dispose();
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
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Create Account',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  defaultFormField(
                    type: TextInputType.text,
                    controller: nameController,
                    text: 'Name',
                    validate: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Name must not be empty !';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  defaultFormField(
                    controller: passController,
                    text: 'Password',
                    type: TextInputType.visiblePassword,
                    suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                    isPassword: isPassword,
                    suffixPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                        print('==================== suffixPressed');
                        // TextInputType.text;
                      });
                    },
                    prefix: Icons.lock,
                    validate: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Password must not be empty';
                      } else if (!passwordRegex.hasMatch(value)) {
                        return 'Password must be at least 8+ chars,letters & digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.0),

                  defaultButton(
                    function: () async {
                      if(kDebugMode){
                        print('====================OnButton Pressed');
                      }
                      if (formState.currentState?.validate()??false) {
                        String currentUsername = nameController!.text;
                        bool usernameExists = await quotesDb.doesUserNameExist(
                          currentUsername,
                        );
                        if (usernameExists) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'UserName"$currentUsername" is already taken. Please choose another',
                                ),
                                // backgroundColor: Colors.purpleAccent[100],
                              ),
                            );
                          }
                          return;
                        }
                        try {
                          // --- Hashing Steps ---
                          final String hashedPassword = BCrypt.hashpw(
                            passController!.text,
                            BCrypt.gensalt(),
                          );
                          UserModel newUser = UserModel(
                            userName:currentUsername,
                            hashPassword: hashedPassword,
                          );
                          Map<String, dynamic> userMap = newUser.toMap();
                          int resultId = await quotesDb.insertModelData(
                            'users',
                            userMap,
                          );
                          if (resultId != 0 && resultId != -1) {
                            if (kDebugMode) {
                              print(
                                'User inserted successfully with ID:$resultId',
                              );
                            }
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Registration successful !'),
                                ),
                              );
                              // Navigator.pushReplacementNamed(context, '/homelayout');
                              Navigator.pushNamedAndRemoveUntil(context, '/homelayout', (Route<dynamic>route)=>false);
                            }
                          } else {
                            if (kDebugMode) {
                              print('Failed to insert user !');
                            }
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    usernameExists
                                    ?'Username "$currentUsername" is already taken.'
                                    :'Registration failed. Please try again ',
                                  ),
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print('Error inserting user :$e');
                          }
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'An error occurred during registration.',
                                ),
                              ),
                            );
                          }
                        }
                      } else {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please correct the error in the form.',
                              ),
                            ),
                          );
                        }
                      }
                    },
                    text: 'Register',
                  ),
                  txtButton(
                    txt: 'You already have an account,',
                    txtBtn: 'Sign In',
                    onPressed: () {
                      Navigator.pushNamed(context, '/signIn');
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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qute_app/layout/home_layout_with_cubit.dart';
import 'package:qute_app/modules/archive/archived_screen.dart';
import 'package:qute_app/modules/init/welcome_screen.dart';
import 'package:qute_app/modules/login/sign_in_with_cubit.dart';
import 'package:qute_app/modules/register/register_with_cubit.dart';
import 'package:qute_app/modules/sign_out/sign_out_screen.dart';
import 'package:qute_app/modules/splash_screen/splash_screen.dart';
import 'package:qute_app/shared/cubit/cubit.dart';
import 'package:qute_app/shared/cubit/states.dart';
import 'package:qute_app/shared/styles/bloc_observer.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
  Bloc.observer=MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (BuildContext providerContext)=>AppCubit()..loadUserQuotes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          splashFactory: InkSplash.splashFactory,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.cyan,
            // unselectedItemColor: Colors.grey,
          )

        ),
        routes: {
          '/welcome':(context)=>WelcomeScreen(),
          '/register':(context)=>RegisterWithCubitScreen(),
          '/signIn':(context)=>SignInWithCubitScreen(),
          '/homelayout':(context)=>HomeLayoutWithCubit(),
          '/archived':(context)=>ArchivedScreen(),
          '/signOut':(context)=>SignOutScreen(),
        },
        home:BlocConsumer<AppCubit,AppStates>(
          listener: (BuildContext listenerContext,AppStates state) {
            if (kDebugMode) {
              print('Main BlocConsumer listener reacting to state: $state');
            }
          },
          builder: (BuildContext cubitContext,AppStates state) {
          if (kDebugMode) {
            final userName=AppCubit.get(cubitContext).currentUser?.userName;
            print('Main BlocBuilder reacting to state :$state,Current User:$userName');
          }
          if(state is AuthenticatedState){
            return HomeLayoutWithCubit();
          }
          else if(state is AppInitialState ||
              ( state is UserLoadingState && AppCubit.get(cubitContext).currentUser==null)){
            return SplashScreen();
          }
          else if(state is UnauthenticatedState||state is AuthErrorState){
            return WelcomeScreen();
          }
            if (kDebugMode) {
              print('Main BlocConsumer fallback, current state: $state');
            }
          return HomeLayoutWithCubit();
        },)
      ),
    );
  }
  
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qute_app/shared/components/components.dart';
import 'package:qute_app/shared/cubit/cubit.dart';
import 'package:qute_app/shared/cubit/states.dart';
import '../models/quote_model.dart';


class HomeLayoutWithCubit extends StatelessWidget {
 const HomeLayoutWithCubit({super.key});
 // final _scaffoldKey = GlobalKey<ScaffoldState>();
 // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: cubit.scaffoldKey,
          appBar: AppBar(
            title: cubit.titles[cubit.currentIndex],
            elevation:2 ,
            actions: [
              PopupMenuButton<String>(
              onSelected: (value) {
                if(value=='archived'){
                  Navigator.pushNamed(context, '/archived');
                  }

                if(value=='sign out'){

                  if(kDebugMode){
                    print('Navigate to sing out .');
                  }
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text('Confirm Account Deletion',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            Text('Are you sure you want to sign out?'),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text('Cancel')),
                        TextButton(
                          // style:TextButton.styleFrom(foregroundColor:Colors.red),
                            onPressed: (){
                            cubit.logout();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/signIn',
                                  (Route<dynamic> route) => false,
                            );
                            },
                            child: Text('SIGN OUT'),
                        ),
                      ],
                    );
                  },);
                  
                }
                if(value=='delete account'){
                  if(kDebugMode){
                    print('Navigate to Delete account.');
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text('Confirm Account Deletion'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text('Are you sure you want to permanently delete your account?'),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('This will erase all your data, including all your quotes. This action cannot be undone.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text('Cancel')),
                          TextButton(
                            style:TextButton.styleFrom(foregroundColor:Colors.red),
                            onPressed: (){
                              cubit.deleteCurrentUserAccount();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/welcome',
                                    (Route<dynamic> route) => false,
                              );
                            },
                            child: Text('DELETE MY ACCOUNT'),
                          ),
                        ],
                      );
                    },);
                  }
                }
              },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'archived',child:Text('Archived') ,),
                  PopupMenuItem(value: 'sign out',child: Text('Sign out'),),
                  PopupMenuItem(value: 'delete account',child: Text('Delete Account'),)
                ],icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (cubit.isBottomSheetShown) {
                if (cubit.formKey.currentState!.validate()) {
                  if(cubit.isEditingQuote){
                    await cubit.saveUpdatedQuote();
                  }else{
                    UserQuoteModel newQuoteData = UserQuoteModel(
                      userId: cubit.currentUser!.userId!,
                      quoteText: cubit.quoteController.text,
                      author: cubit.authorController.text,
                    );
                    Map<String, dynamic> quoteMap = newQuoteData.toMap();
                    await cubit.addQuote('user_quotes', quoteMap);
                  }
                  if (context.mounted) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  }
                  cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                  cubit.quoteController.clear();
                  cubit.authorController.clear();
                  cubit.quoteBeingEdited=null;
                }
              } else {
                if(!cubit.isEditingQuote){
                  cubit.quoteController.clear();
                  cubit.authorController.clear();
                }
                cubit.scaffoldKey.currentState
                    ?.
                showBottomSheet(
                      (context) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: cubit.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                controller: cubit.quoteController,
                                type: TextInputType.text,
                                text: 'Quote',
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Quote must not be empty';
                                  }
                                  return null;
                                },
                                prefix: Icons.format_quote,
                              ),
                              SizedBox(height: 15.0),
                              defaultFormField(
                                type: TextInputType.text,
                                controller: cubit.authorController,
                                text: 'Author',
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Author must not be empty';
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .closed
                    .then((value) {
                      if (context.mounted) {
                        cubit.changeBottomSheetState(
                          isShow: false,
                          icon: Icons.edit,
                        );
                        if(cubit.isEditingQuote){
                          cubit.cancelEditQuote();
                        }
                      }
                    });
                cubit.changeBottomSheetState(isShow: true,
                    icon:cubit.isEditingQuote? Icons.save:Icons.add);
              }

              if (kDebugMode) {
                print('Attempting to fetch users .....');
                try {
                  List<Map<String, dynamic>> users = await cubit.quotesDb
                      .getAllRows('users');
                  if (users.isEmpty) {
                    print('No users found in the database');
                  } else {
                    print('The users are:');
                    for (var userMap in users) {
                      print(
                        'Username:${userMap['user_name']},Password:${userMap['password_hash']}',
                      );
                    }
                  }
                } catch (e) {
                  print('Error fetching users :$e');
                }
              }

              if (kDebugMode) {
                print('Attempting to fetch Quotes .....');
                try {
                  List<Map<String, dynamic>> quote = await cubit.quotesDb
                      .getAllRows('user_quotes');
                  if (quote.isEmpty) {
                    print('No quote found in the database');
                  } else {
                    print('The quote are:');
                    for (var quoteMap in quote) {
                      print(
                        'quote:${quoteMap['quote_text']},author:${quoteMap['author']}',
                      );
                    }
                  }
                } catch (e) {
                  print('Error fetching quotes :$e');
                }
              }
            },
            shape: StadiumBorder(),
            child: Icon(cubit.fabIcon),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 20.0,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.format_quote),
                icon: Icon(Icons.format_quote_outlined),
                label: 'Quotes',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite),
                icon: Icon(Icons.favorite_outline),
                label: 'Favorites',
              ),
            ],
          ),
          body:
              state is AppGetDatabaseLoadingState
                  ? Center(child: CircularProgressIndicator())
                  : cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}

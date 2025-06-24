import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qute_app/models/quote_model.dart';
import 'package:qute_app/shared/cubit/cubit.dart';

// Widget DefaultButton({
//   double width = double.infinity,
//   Color background = Colors.cyan,
//   required String title,
//   required VoidCallback onPressed,
//   double elevate = 5.0,
// }) => Container(
//   width: width,
//   padding: EdgeInsets.all(10.0),
//   child: MaterialButton(
//     hoverColor: Colors.grey,
//     onPressed: () {
//       onPressed;
//     },
//
//     // color: Colors.blue,
//     child: Text(title, style: TextStyle(color: Colors.white, fontSize: 15.0)),
//   ),
// );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.cyan,
  bool isUppercase = true,
  required VoidCallback function,
  required String text,
}) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(
    padding: EdgeInsets.only(top: 3, left: 3),
    width: width,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.black),
        left: BorderSide(color: Colors.black),
        right: BorderSide(color: Colors.black),
        top: BorderSide(color: Colors.black),
      ),
      borderRadius: BorderRadius.circular(50.0),
    ),

    child: MaterialButton(
      color: background,
      minWidth: double.infinity,
      height: 55.0,
      elevation: 0.0,
      onPressed: function,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Text(
        isUppercase ? text.toUpperCase() : text,
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
);

Widget defaultFormField({
  TextEditingController? controller,
  required TextInputType type,
  required String? text,
  ValueChanged? onSubmite,
  ValueChanged? onChange,
  FormFieldValidator? validate,
  IconData? prefix,
  IconData? suffix,
  bool isPassword = false,
  VoidCallback? suffixPressed,
}) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: TextFormField(
    controller: controller,
    obscureText: isPassword,
    keyboardType: type,
    onFieldSubmitted: onSubmite,
    onChanged: onChange,
    validator: validate,
    decoration: InputDecoration(
      labelText: text,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      suffixIcon:
          suffix != null
              ? IconButton(icon: Icon(suffix), onPressed: suffixPressed)
              : null,
      prefixIcon: Icon(prefix),
    ),
  ),
);

Widget txtButton({
  required String txt,
  required String txtBtn,
  required VoidCallback onPressed,
  FontWeight fontWeight = FontWeight.bold,
}) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(txt, style: TextStyle(fontWeight: FontWeight.bold)),
    TextButton(
      onPressed: onPressed,
      child: Text(txtBtn, style: TextStyle(fontWeight: fontWeight)),
    ),
  ],
);

Widget buildQuoteItems(UserQuoteModel quoteModel, context) {
  AppCubit cubit = AppCubit.get(context);
  return Dismissible(
    key: Key(quoteModel.quoteId.toString()),
    background: Container(
      color: Colors.black87,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.unarchive, color: Colors.white60),
    ),
    secondaryBackground: Container(
      color: Colors.cyan,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.archive, color: Colors.white60),
    ),

    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        margin: EdgeInsets.all(2.0),
        surfaceTintColor: Colors.white60,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  quoteModel.quoteText,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                dense: true,
                subtitle: Text(quoteModel.author ?? 'UnKnown author' ,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                ),
                isThreeLine: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      cubit.toggleFavoriteStatus(quoteModel);
                    },
                    icon:
                        quoteModel.isFavorite
                            ? Icon(Icons.favorite,color: Colors.cyan,)
                            : Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () async {
                      cubit.startEditingQuote(quoteModel);
                      cubit.scaffoldKey.currentState?.showBottomSheet(
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
                      );
                      if (cubit.isBottomSheetShown) {
                        if (cubit.formKey.currentState!.validate()) {
                          if (kDebugMode) {
                            print(
                              'Update Icon onPressed =============-----------==. ',
                            );
                          }
                          cubit.changeBottomSheetState(
                            isShow: false,
                            icon: Icons.edit,
                          );

                          cubit.quoteController.clear();
                          cubit.authorController.clear();
                          if (!cubit.isBottomSheetShown) {}
                        }
                      }
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.removeQuote(quoteModel);
                    },
                    icon: Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    confirmDismiss: (direction) async {
      if (direction == DismissDirection.endToStart) {
        return true;
      } else if (direction == DismissDirection.startToEnd) {
        return false;
      }
      return false;
    },
    onDismissed: (direction) {
        cubit.toggleArchiveStatus(quoteModel);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              quoteModel.isArchived
                  ? "'${quoteModel.quoteText}'unarchived"
                  : "'${quoteModel.quoteText}'archived",
            ),
          ),
        );
    },
  );
}


Widget buildArchivedItems(UserQuoteModel quoteModel, context) {
  AppCubit cubit = AppCubit.get(context);
  return Dismissible(
    key: Key(quoteModel.quoteId.toString()),
    background: Container(
      color: Colors.black87,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.unarchive, color: Colors.white60),
    ),
    secondaryBackground: Container(
      color: Colors.cyan,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.archive, color: Colors.white60),
    ),

    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        margin: EdgeInsets.all(2.0),
        surfaceTintColor: Colors.white60,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  quoteModel.quoteText,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                dense: true,
                subtitle: Text(quoteModel.author ?? 'UnKnown author' ,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                isThreeLine: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      cubit.removeQuote(quoteModel);
                    },
                    icon: Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    confirmDismiss: (direction) async {
      if (direction == DismissDirection.endToStart) {
        return true;
      } else if (direction == DismissDirection.startToEnd) {
        return false;
      }
      return false;
    },
    onDismissed: (direction) {
      cubit.toggleArchiveStatus(quoteModel);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            quoteModel.isArchived
                ? "'${quoteModel.quoteText}'unarchived"
                : "'${quoteModel.quoteText}'archived",
          ),
        ),
      );
    },
  );
}

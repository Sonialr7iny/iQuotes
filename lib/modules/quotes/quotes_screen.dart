import 'package:flutter/material.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Quotes',style: TextStyle(
        fontWeight: FontWeight.bold
      ),),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qute_app/modules/favorites/favorites_screen.dart';

import '../modules/quotes/quotes_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    QuotesScreen(),
    FavoritesScreen(),
  ];
  List<Widget> titles = [
    Row(
      children: [
        Text('i', style: TextStyle(
            color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 25.0)),
        Text('Quotes',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        Icon(Icons.format_quote, color: Colors.cyan, size: 29.0),

      ],
    ),
    Row(
      children: [
        Text('i', style: TextStyle(
            color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 25.0)),
        Text('Favorites',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        Icon(Icons.favorite_outline_sharp, color: Colors.cyan, size: 22.0),

      ],
    )

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:titles[currentIndex],
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.more_vert))
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(onPressed: () {},
        shape: StadiumBorder(),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        elevation: 20.0,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;

          });
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.format_quote),
            icon: Icon(Icons.format_quote_outlined,),
            label: 'Quotes',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Models/meal.dart';
import './favourites_screen.dart';
import './categories_screen.dart';
import '../Widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  TabsScreen(this.favouriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // var topTabs = DefaultTabController(
  //   length: 2,
  //   child: Scaffold(
  //     appBar: AppBar(
  //       title: Text('Meals'),
  //       bottom: TabBar(
  //         tabs: <Widget>[
  //           Tab(
  //             icon: Icon(
  //               Icons.category,
  //             ),
  //             text: 'Categories',
  //           ),
  //           Tab(
  //             icon: Icon(
  //               Icons.favorite,
  //             ),
  //             text: 'Favourites',
  //           ),
  //         ],
  //       ),
  //     ),
  //     body: TabBarView(
  //       children: <Widget>[
  //         CategoriesScreen(),
  //         FavourtiesScreen(),
  //       ],
  //     ),
  //   ),
  // );

  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavourtiesScreen(widget.favouriteMeals),
        'title': 'Favourites',
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favourites',
          ),
        ],
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

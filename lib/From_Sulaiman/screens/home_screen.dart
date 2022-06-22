import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/firbase.dart';
import '../components/drawer.dart';
import '../components/home.dart';

import '../components/menu.dart';
import '../components/orders.dart';
import '../components/settings.dart';
import '../components/support folder/support_page.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAthentications firbaseFunctions = FirebaseAthentications();
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _kBottomNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart), label: 'Order'),
      const BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
      const BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.headset), label: 'Support'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.settings), label: 'Setting'),
    ];
    final _kTapPages = <Widget>[
      const Home(),
      const Order(),
      Menu(),
      SupportPage(),
      Setting(),
    ];

    assert(_kTapPages.length == _kBottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      backgroundColor: Color(0xffFF3F02),
      selectedItemColor: Colors.white,
      items: _kBottomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                firbaseFunctions.logoutUser(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              icon: const Icon(Icons.lock))
        ],
        backgroundColor: Color(0xffFF3F02),
        title: const Text(
          'Restaurant App',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.00,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // leading: const Icon(Icons.notifications),
      ),
      drawer: const DrawerNavBar(),
      body: _kTapPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}

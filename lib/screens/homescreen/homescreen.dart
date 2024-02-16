import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kungwi/screens/account/account_page.dart';
import 'package:kungwi/screens/homepage/homepage.dart';

import 'package:kungwi/screens/series/series_home_page.dart';

class HomeScreenPage extends ConsumerStatefulWidget {
  const HomeScreenPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends ConsumerState<HomeScreenPage> {
  int _selectedIndex = 0;
  bool loading = false;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    // const SearchPage(),
    const SeriesPage(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // signOut();
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.video,
              ),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     FontAwesomeIcons.magnifyingGlass,
            //   ),
            //   label: 'Search',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.rss,
              ),
              label: 'Series',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.circleInfo,
              ),
              label: 'Info',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

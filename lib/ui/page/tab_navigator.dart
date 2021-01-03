import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comic_read/ui/helper/color_helper.dart';
import 'package:comic_read/ui/page/profile_page.dart';
import 'package:comic_read/ui/page/shelf_page.dart';
import 'package:comic_read/ui/page/find_page.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Widget> pages = <Widget>[
  ShelfPage(),
  FindPage(),
  ProfilePage(),
];

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  DateTime _lastPressed;
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (_lastPressed == null ||
                DateTime.now().difference(_lastPressed) >
                    Duration(seconds: 1)) {
              //两次点击间隔超过1秒则重新计时
              _lastPressed = DateTime.now();
              return false;
            }
            return true;
          },
          child: PageView.builder(
            itemBuilder: (ctx, index) => pages[index],
            itemCount: pages.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4.0,
        backgroundColor: _theme.bottomAppBarColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: redC1),
        unselectedIconTheme: IconThemeData(color: Colors.black),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.book), label: "书架"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.draftingCompass), label: "发现"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userAstronaut), label: "个人"),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

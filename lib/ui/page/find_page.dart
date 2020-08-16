import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:comic_read/model/book.dart';
import 'package:comic_read/ui/page/search_page.dart';
import 'package:comic_read/ui/widget/find_flow_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  TextEditingController searchKeyController;

  List<Book> _bookList = buildTestBooks();
  Size screenSize;
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      // search appbar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenSize.height * 0.1),
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: screenSize.width - 40,
                  height: screenSize.height * 0.1 - 40,
                  decoration: BoxDecoration(
                    color: _theme.disabledColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.search,
                        size: 16,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Search", style: _theme.textTheme.button),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 80,
                  height: screenSize.height * 0.1 - 40,
                  decoration: BoxDecoration(
                    color: _theme.bottomAppBarColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.artstation,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // find flow view
      body: ListView(
        children: <Widget>[
          FindFLowView("腾讯漫画", _bookList),
          FindFLowView("网易漫画", _bookList),
          FindFLowView("哔哩哔哩漫画", _bookList),
        ],
      ),
    );
  }
}

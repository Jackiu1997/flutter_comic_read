import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comic_read/model/book.dart';
import 'package:comic_read/ui/helper/color_helper.dart';
import 'package:comic_read/ui/page/detail_page.dart';
import 'package:comic_read/ui/page/search_page.dart';
import 'package:comic_read/ui/widget/book_grid_card.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShelfPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShelfPageState();
}

class _ShelfPageState extends State<ShelfPage> {
  List<Book> _bookList = buildTestBooks();
  List<int> _lastReadBooksIndex = [0, 1, 2];

  bool _gridView = false;
  Size screenSize;
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenSize.height * 0.1),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Library", style: _theme.textTheme.headline1),
              Container(
                width: 100,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: redC1,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: FaIcon(
                        _gridView
                            ? FontAwesomeIcons.stream
                            : FontAwesomeIcons.thLarge,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        _gridView = !_gridView;
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.search,
                        color: Colors.white,
                        size: 16,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          // last read card
          SizedBox.fromSize(
            size: Size.fromHeight((screenSize.width - 40) / 1.5),
            child: Swiper(
              itemCount: 3,
              scale: 0.7,
              duration: 500,
              itemBuilder: (context, index) =>
                  _buildLastReadCard(_bookList[_lastReadBooksIndex[index]]),
            ),
          ),
          // shelf bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("正在阅读", style: _theme.textTheme.subtitle2),
                Container(
                  width: 50,
                  height: 35,
                  decoration: BoxDecoration(
                    color: _theme.bottomAppBarColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.angleDown,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          // shelf grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(left: 22),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3.0 / 4.4,
              ),
              itemCount: _bookList.length,
              itemBuilder: (context, index) => BookGridCard(_bookList[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastReadCard(Book book) {
    return GestureDetector(
      onTapDown: (detail) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(book),
          ),
        );
      },
      child: Container(
        height: (screenSize.width - 40) / 1.5,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(book.cover),
            fit: BoxFit.cover,
          ),
          color: _theme.backgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 2),
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                width: screenSize.width - 40,
                height: 60,
                decoration: BoxDecoration(
                  color: _theme.bottomAppBarColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          book.name,
                          style: _theme.primaryTextTheme.bodyText1,
                        ),
                        Text(
                          "最新章节 -- 第148话 万亿分身",
                          style: _theme.primaryTextTheme.bodyText2,
                        ),
                      ],
                    ),
                    FaIcon(
                      FontAwesomeIcons.play,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

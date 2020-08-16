import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comic_read/model/book.dart';
import 'package:comic_read/model/book_source.dart';
import 'package:comic_read/ui/widget/book_list_card.dart';
import 'package:comic_read/utils/AnalyzeBookSource.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchKeyController = TextEditingController();
  Size screenSize;
  ThemeData _theme;

  List<Book> _bookList;
  BookSource sfacgRule;

  String keyword;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/book.sfacg.com.json")
        .then((onValue) {
      sfacgRule = BookSource.fromJson(jsonDecode(onValue));
    });
  }

  onTapSearch() async {
    var text = searchKeyController.text;
    print(text);
    if (text.isNotEmpty) {
      keyword = text;
      //重置搜索结果
      _bookList = new List<Book>();
      await getSearchList();
    }
  }

  getSearchList() async {
    loading = true;
    setState(() {});

    var booksdata = await AnalyzeBookSource.analyzeSearchResult(sfacgRule.search, keyword);
    _bookList = booksdata.map((e) => Book(name: e.name, cover: e.cover));

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    _theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // search appbar
            Container(
              height: screenSize.height * 0.06,
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
                          Expanded(
                            child: TextField(
                              showCursor: false,
                              controller: searchKeyController,
                              style: _theme.textTheme.button,
                              decoration: InputDecoration(
                                hintText: "Search",
                                contentPadding: EdgeInsets.only(left: 20),
                                border: InputBorder.none,
                              ),
                              onSubmitted: onTapSearch(),
                            ),
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
                        onPressed: onTapSearch(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // search books list
            Expanded(
              child: (loading || _bookList.isEmpty)
                  ? Center(
                      child: Text(
                        "无图书",
                        style: _theme.textTheme.bodyText1,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: getSearchList(),
                      child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _bookList.length,
                      itemBuilder: (context, index) =>
                          BookListCard(_bookList.elementAt(index)),
                      separatorBuilder: (context, index) => Divider(
                        indent: 5,
                        color: _theme.backgroundColor,
                      ),
                    ),
                  ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          print(_bookList.length.toString());
          setState(() {});
        },
      ),
    );
  }
}

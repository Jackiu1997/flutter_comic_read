import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:comic_read/model/book.dart';
import 'package:comic_read/ui/helper/color_helper.dart';
import 'package:comic_read/ui/page/content_page.dart';
import 'package:comic_read/ui/widget/book_grid_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Book _book;

  DetailPage(this._book);

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  bool _isListView = true;
  TabController _controller;
  ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return ChangeNotifierProvider<Book>.value(
      value: widget._book,
      child: Scaffold(
        backgroundColor: _theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: _theme.backgroundColor,
          elevation: 0,
          iconTheme: _theme.iconTheme,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: FaIcon(FontAwesomeIcons.shareAlt),
              onPressed: () {},
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.heartbeat),
              onPressed: () {},
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Column(
          children: <Widget>[
            // book info head
            _buildBookInfoHead(),
            // 简介 章节切换tab
            TabBar(
              controller: _controller,
              isScrollable: true,
              indicatorColor: redC1,
              indicatorWeight: 3.0,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.symmetric(horizontal: 60),
              labelColor: _theme.primaryColor,
              labelStyle: _theme.textTheme.bodyText1,
              tabs: <Widget>[Text("简介"), Text("章节")],
            ),
            // 章节列表
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  _buildIntroTabView(),
                  _buildChapterTabView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookInfoHead() {
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // book cover
          Container(
            height: 190,
            width: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget._book.cover,
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          // book message
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 160,
                  height: 100,
                  child: Text(
                    widget._book.name,
                    style: _theme.textTheme.headline2,
                  ),
                ),
                Text(
                  "阅读至  ${widget._book.readChapter}",
                  style: _theme.textTheme.bodyText2,
                ),
                Text(
                  "更新至  ${widget._book.lastChapter}",
                  style: _theme.textTheme.bodyText2,
                ),
                FlatButton.icon(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  color: _theme.bottomAppBarColor,
                  icon: FaIcon(
                    FontAwesomeIcons.readme,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Read Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContentPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroTabView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // intro
          Flexible(
            flex: 5,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: _theme.disabledColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(widget._book.summary, style: _theme.textTheme.bodyText2),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(" 推荐阅读", style: _theme.textTheme.subtitle2),
          ),
          Flexible(
            flex: 4,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  BookGridCard(widget._book),
                  BookGridCard(widget._book),
                  BookGridCard(widget._book),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterTabView() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "  阅读进度： ${widget._book.readIndex} / ${widget._book.chapters.length}",
                style: _theme.textTheme.bodyText1,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    iconSize: 16,
                    icon: FaIcon(
                      FontAwesomeIcons.sortNumericUp,
                      color: _theme.primaryColor,
                    ),
                    onPressed: () {
                      widget._book.chapters =
                          List.from(widget._book.chapters.reversed);
                      setState(() {});
                    },
                  ),
                  IconButton(
                    iconSize: 16,
                    icon: FaIcon(
                      _isListView
                          ? FontAwesomeIcons.listUl
                          : FontAwesomeIcons.borderAll,
                      color: _theme.primaryColor,
                    ),
                    onPressed: () {
                      _isListView = !_isListView;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: _isListView
              ? ListView.builder(
                  itemCount: widget._book.chapters.length,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(2),
                    height: 40,
                    child: FlatButton(
                      color: widget._book.readIndex == index
                          ? _theme.bottomAppBarColor
                          : _theme.disabledColor,
                      onPressed: () {
                        widget._book.readIndex = index;
                        setState(() {});
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContentPage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget._book.chapters[index].name,
                            style: _theme.textTheme.bodyText2,
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                )
              : GridView.builder(
                  itemCount: widget._book.chapters.length,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(2),
                    child: FlatButton(
                      color: widget._book.readIndex == index
                          ? _theme.bottomAppBarColor
                          : _theme.disabledColor,
                      child: Text(
                        widget._book.chapters[index].name,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: _theme.textTheme.bodyText2,
                      ),
                      onPressed: () {
                        widget._book.readIndex = index;
                        setState(() {});
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContentPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4.0 / 1.0,
                  ),
                ),
        ),
      ],
    );
  }
}

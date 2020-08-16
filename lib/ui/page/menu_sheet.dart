import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comic_read/model/book.dart';
import 'package:comic_read/ui/page/content_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MenuSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuSheetState();
}

class _MenuSheetState extends State<MenuSheet> {
  ThemeData _theme;
  bool _isListView = true;
  Book _book;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _book = Provider.of<Book>(context);

    return Container(
      height: 500,
      child: Column(
        children: <Widget>[
          AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            backgroundColor: _theme.backgroundColor,
            elevation: 0,
            iconTheme: _theme.iconTheme,
            title: Text(_book.name, style: _theme.textTheme.subtitle2),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              IconButton(
                iconSize: 16,
                icon: FaIcon(
                  FontAwesomeIcons.sortNumericUp,
                  color: _theme.primaryColor,
                ),
                onPressed: () {
                  _book.chapters =
                      List.from(_book.chapters.reversed);
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
              SizedBox(width: 10),
            ],
          ),
          _buildChapterTabView(),
        ],
      ),
    );
  }

  Widget _buildChapterTabView() {
    return Expanded(
      child: Container(
        color: _theme.backgroundColor,
        child: _isListView
            ? ListView.builder(
                itemCount: _book.chapters.length,
                padding: EdgeInsets.symmetric(horizontal: 30),
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(2),
                  height: 40,
                  child: FlatButton(
                    color: _book.readIndex == index
                        ? _theme.bottomAppBarColor
                        : _theme.disabledColor,
                    onPressed: () {
                      _book.readIndex = index;
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
                          _book.chapters[index].name,
                          style: _theme.textTheme.bodyText1,
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              )
            : GridView.builder(
                itemCount: _book.chapters.length,
                padding: EdgeInsets.symmetric(horizontal: 30),
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(2),
                  child: FlatButton(
                    color: _book.readIndex == index
                        ? _theme.bottomAppBarColor
                        : _theme.disabledColor,
                    child: Text(
                      _book.chapters[index].name,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: _theme.textTheme.bodyText2,
                    ),
                    onPressed: () {
                      _book.readIndex = index;
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
    );
  }
}

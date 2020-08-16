import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:comic_read/model/book.dart';

class BookListCard extends StatefulWidget {
  final Book _book;
  final int width;

  BookListCard(this._book, {this.width});

  @override
  State<StatefulWidget> createState() => _BookListCardState();
}

class _BookListCardState extends State<BookListCard> {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    var _coverWidth = widget.width == null ? 80.0 : widget.width;

    return Container(
      height: _coverWidth / 3 * 4,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          // 封面
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              widget._book.cover,
              fit: BoxFit.cover,
              height: _coverWidth / 3 * 4,
              width: _coverWidth.toDouble(),
            ),
          ),
          // 信息流
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(widget._book.name, style: _theme.textTheme.bodyText1),
                ),
                Container(
                  child: Text(widget._book.status, style: _theme.textTheme.bodyText2),
                ),
                Container(
                  child: Text("阅读进度  ${widget._book.readChapter}", style: _theme.textTheme.bodyText2),
                ),
                Container(
                  child: Text("最新章节  ${widget._book.lastChapter}", style: _theme.textTheme.bodyText2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

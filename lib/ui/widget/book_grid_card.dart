import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:comic_read/model/book.dart';
import 'package:comic_read/ui/page/detail_page.dart';


class BookGridCard extends StatefulWidget {
  final Book _book;
  final double width;

  BookGridCard(this._book, {this.width});

  @override
  State<StatefulWidget> createState() => _BookGridCardState();
}

class _BookGridCardState extends State<BookGridCard> {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    var _coverWidth = widget.width == null ? 100.0 : widget.width;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(widget._book),
          ),
        );
      },
      child: Container(
        height: _coverWidth / 3 * 4 + 25,
        width: _coverWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // 封面
            Container(
              height: _coverWidth / 3 * 4,
              width: _coverWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget._book.cover),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 1),
                    blurRadius: 1,
                  ),
                ],
              ),
            ),
            // 书名
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                widget._book.name,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: _theme.textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

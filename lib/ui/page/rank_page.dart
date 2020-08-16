import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comic_read/model/book.dart';
import 'package:comic_read/ui/widget/book_list_card.dart';


class RankPage extends StatefulWidget {
  final String _title;
  final List<Book> _bookList;

  RankPage(this._title, this._bookList);

  @override
  State<StatefulWidget> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  List<String> _typeList = [
    "连载榜",
    "月票榜",
    "更新榜",
    "字数榜",
    "热度榜",
    "连载榜",
    "月票榜",
    "更新榜",
  ];

  var _selectTypeIndex = 0;
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: _theme.backgroundColor,
        iconTheme: _theme.iconTheme,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget._title, style: _theme.textTheme.subtitle2),
        centerTitle: true,
      ),
      body: Row(
        children: <Widget>[
          // 标签列表
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: _typeList.length,
              itemBuilder: (context, index) => Material(
                color: _selectTypeIndex == index
                    ? _theme.bottomAppBarColor
                    : _theme.backgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  onTap: () {
                    _selectTypeIndex = index;
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      _typeList[index],
                      style: _theme.textTheme.subtitle2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 书单列表
          Expanded(
            flex: 7,
            child: ListView.separated(
              padding: EdgeInsets.all(10),
              itemCount: widget._bookList.length,
              itemBuilder: (context, index) =>
                  BookListCard(widget._bookList[index]),
              separatorBuilder: (context, index) => Divider(indent: 5),
            ),
          ),
        ],
      ),
    );
  }
}

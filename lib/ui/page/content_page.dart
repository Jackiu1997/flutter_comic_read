import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comic_read/model/book.dart';
import 'package:comic_read/ui/page/menu_sheet.dart';
import 'package:provider/provider.dart';

class ContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  ScrollController _scrollController = ScrollController();
  ThemeData _theme;
  Book _book;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        lastChapter();
      } else if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        nextChapter();
      }
    });
  }

  Future lastChapter() async {
    setState(() {
      if (_book.readIndex > 0) {
        _book.readIndex--;
        print("last chapter  ${_book.readIndex}");
      }
    });
  }

  Future nextChapter() async {
    setState(() {
      if (_book.readIndex < _book.chapters.length - 1) {
        _book.readIndex++;
        print("next chapter  ${_book.readIndex}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _book = Provider.of<Book>(context);

    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                context: context,
                builder: (context) => MenuSheet(),
              );
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  _book.chapters[_book.readIndex].content.length,
              itemBuilder: (context, index) => Image.network(
                _book.chapters[_book.readIndex].content[index],
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

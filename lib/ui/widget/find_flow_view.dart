import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comic_read/ui/page/rank_page.dart';
import 'package:comic_read/model/book.dart';
import 'package:comic_read/ui/widget/book_grid_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FindFLowView extends StatefulWidget {
  final String _title;
  final List<Book> _bookList;

  FindFLowView(this._title, this._bookList);

  @override
  State<StatefulWidget> createState() => _FindFlowViewState();
}

class _FindFlowViewState extends State<FindFLowView> {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget._title, style: _theme.textTheme.subtitle2),
              Container(
                margin: EdgeInsets.only(right: 20),
                width: 50,
                height: 35,
                decoration: BoxDecoration(
                  color: _theme.bottomAppBarColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  iconSize: 16,
                  icon: FaIcon(
                    FontAwesomeIcons.arrowRight,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RankPage(widget._title, widget._bookList),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 170,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 20),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget._bookList.length,
            itemBuilder: (context, index) =>
                BookGridCard(widget._bookList[index]),
            separatorBuilder: (context, index) => Divider(indent: 15),
          ),
        ),
      ],
    );
  }
}

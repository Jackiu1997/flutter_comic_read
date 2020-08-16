import 'package:comic_read/model/book_source.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
// for js meathod

class AnalyzeBookSource {
  static Future<List<Search>> analyzeSearchResult(
      Search searchRule, String key) async {
    List<Search> searchList = new List<Search>();

    var searchUrl = searchRule.url.replaceFirst('\${key}', key);
    var response = await http
        .get('https://ac.qq.com/Comic/searchList?search=%E9%AD%94%E7%8E%8B');
    if (response.statusCode == 200) {
      Document document = parse(response.body);
      List<Element> elementList = document.querySelectorAll(searchRule.list);

      for (var element in elementList) {
        Search searchBook = new Search();
        searchBook
          ..name ??= element.querySelector(searchRule.name)?.text
          ..cover ??= element
              .querySelector(searchRule.cover)
              ?.attributes['data-original'];
        if (searchBook.name != null) searchList.add(searchBook);
      }
    } else {
      print("error:" + response.statusCode.toString());
    }

    return searchList;
  }

  static Future<Detail> analyzeDetailResult(
      Detail detailRule, String detailUrl) async {
    var response = await http.get(detailUrl);
    Document document = parse(response.body);

    Detail detailBook = new Detail();
    detailBook
      ..name ??= document.querySelector(detailRule.name)?.text
      ..author ??= document.querySelector(detailRule.author)?.text
      ..cover ??= document.querySelector(detailRule.cover)?.attributes['src']
      ..summary ??= document.querySelector(detailRule.summary)?.text
      ..status ??= document.querySelector(detailRule.status)?.text
      ..update ??= document.querySelector(detailRule.update)?.text
      ..lastChapter ??= document.querySelector(detailRule.lastChapter)?.text
      ..catalog ??=
          document.querySelector(detailRule.catalog)?.attributes['href'];

    return detailBook.name != null ? detailBook : null;
  }

  static Future<List<Catalog>> analyzeCatalogResult(
      Catalog catalogRule, String catalogUrl) async {
    var response = await http.get(catalogUrl);
    Document document = parse(response.body);

    List<Element> elementList = document.querySelectorAll(catalogRule.list);
    List<Catalog> catalogList;

    elementList.map((f) {
      Catalog listOne = new Catalog();
      listOne
        ..name ??= document.querySelector(catalogRule.name)?.text
        ..chapter ??=document.querySelector(catalogRule.chapter)?.attributes['href'];
      if (listOne.name != null) catalogList.add(listOne);
    });

    return catalogList;
  }

  static Future<List<String>> analyzeChapterResult(
      Chapter chapterRule, String chapterUrl) async {
    var response = await http.get(chapterUrl);
    Document document = parse(response.body);

    //List<Element> elementList = document.querySelectorAll(chapterRule.content);
    List<String> contentList = [
      "https://manhua.qpic.cn/manhua_detail/0/11_17_00_1db00d6275c817b31e39c8d952b6f6c8_8280.jpg/0",
      "https://manhua.qpic.cn/manhua_detail/0/11_17_00_1b67c298b209c336e43c713cb045f24f_8281.jpg/0",
      "https://manhua.qpic.cn/manhua_detail/0/11_17_00_d3dd3facfb2527f2c07dc5b370c0cedb_8282.jpg/0",
      "https://manhua.qpic.cn/manhua_detail/0/11_17_00_f87e8a1363c85b1381fa8dff21cd9d7a_8283.jpg/0",
      "https://manhua.qpic.cn/manhua_detail/0/11_17_00_0bf14ed05cab27f25ae31956bb25be31_8284.jpg/0",
    ];

    return contentList;
  }
}

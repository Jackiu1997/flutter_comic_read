import 'package:comic_read/model/book_source.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
// for js meathod

class AnalyzeWebbook {
  static Future<List<SearchRule>> analyzeSearchResult(
      BookSource source, String searchKey) async {
    var searchRule = source.search;
    var searchList = new List<SearchRule>();

    // input searchUrl and decode Uri
    var searchUrl = searchRule.url.replaceFirst('\${key}', Uri.encodeComponent(searchKey));
    var response = await http.get(searchUrl);
    if (response.statusCode == 200) {
      Document doc = parse(response.body);

      List<Element> eleList = doc.querySelectorAll(searchRule.list);
      for (var element in eleList) {
        SearchRule searchBook = new SearchRule();
        searchBook
          ..name ??= element.querySelector(searchRule.name)?.text
          ..cover ??= element
              .querySelector(searchRule.cover)
              ?.attributes['data-original']
          ..detail ??=
              'https://' + source.url + element.querySelector(searchRule.detail)?.attributes['href'];
        if (searchBook.name != null) searchList.add(searchBook);
      }
    } else {
      print("crawl search error:" + response.statusCode.toString());
    }

    return searchList;
  }

  static Future<DetailRule> analyzeDetailResult(
      BookSource source, String detailUrl) async {
    var detailRule = source.detail;
    var detailBook = new DetailRule();

    var response = await http.get(detailUrl);
    if (response.statusCode != 200) {
      print("crawl detail error:" + response.statusCode.toString());
    } else {
      Document doc = parse(response.body);

      detailBook
        ..name ??= doc.querySelector(detailRule.name)?.text
        ..author ??= doc.querySelector(detailRule.author)?.text
        ..cover ??= doc.querySelector(detailRule.cover)?.attributes['src']
        ..summary ??= doc.querySelector(detailRule.summary)?.text
        ..status ??= doc.querySelector(detailRule.status)?.text
        ..update ??= doc.querySelector(detailRule.update)?.text
        ..lastChapter ??= doc.querySelector(detailRule.lastChapter)?.text
        ..catalog ??= doc.querySelector(detailRule.catalog)?.attributes['href'];
    }
    return detailBook;
  }

  static Future<List<CatalogRule>> analyzeCatalogResult(
      BookSource source, String catalogUrl) async {
    var catalogRule = source.catalog;
    var catalogList = new List<CatalogRule>();

    var response = await http.get(catalogUrl);
    if (response.statusCode != 200) {
      print("crawl catalog error:" + response.statusCode.toString());
    } else {
      Document doc = parse(response.body);

      List<Element> eleList = doc.querySelectorAll(catalogRule.list);
      eleList.map((f) {
        CatalogRule listOne = new CatalogRule();
        listOne
          ..name ??= doc.querySelector(catalogRule.name)?.text
          ..chapter ??= doc.querySelector(catalogRule.chapter)?.attributes['href'];
        if (listOne.name != null) catalogList.add(listOne);
      });
    }

    return catalogList;
  }

  static Future<List<String>> analyzeChapterResult(
      BookSource source, String chapterUrl) async {
    var chapterRule = source.chapter;
    var contentList = new List<String>();

    var response = await http.get(chapterUrl);
    if (response.statusCode != 200) {
      print("crawl chapter error:" + response.statusCode.toString());
    } else {
      Document doc = parse(response.body);

      List<Element> eleList = doc.querySelectorAll(chapterRule.content);
      contentList = [
        "https://manhua.qpic.cn/manhua_detail/0/11_17_00_1db00d6275c817b31e39c8d952b6f6c8_8280.jpg/0",
        "https://manhua.qpic.cn/manhua_detail/0/11_17_00_1b67c298b209c336e43c713cb045f24f_8281.jpg/0",
        "https://manhua.qpic.cn/manhua_detail/0/11_17_00_d3dd3facfb2527f2c07dc5b370c0cedb_8282.jpg/0",
        "https://manhua.qpic.cn/manhua_detail/0/11_17_00_f87e8a1363c85b1381fa8dff21cd9d7a_8283.jpg/0",
        "https://manhua.qpic.cn/manhua_detail/0/11_17_00_0bf14ed05cab27f25ae31956bb25be31_8284.jpg/0",
      ];
    }

    return contentList;
  }
}

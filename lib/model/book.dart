import 'package:flutter/cupertino.dart';
import 'package:comic_read/model/book_source.dart';

class Book with ChangeNotifier {
  BookSource booksource;
  String name = '';
  String author = '';
  String cover = '';
  String summary = '';
  String status = '';
  String update = '';
  String lastChapter = '';
  int readIndex = 0;
  List<Chapter> chapters;

  String get readChapter => chapters[readIndex].name;

  Book(
      {this.booksource,
      this.name,
      this.author,
      this.cover,
      this.summary,
      this.status,
      this.update,
      this.lastChapter,
      this.readIndex,
      this.chapters}) {
    readIndex = 0;
  }

  Book.fromJson(Map<String, dynamic> json) {
    booksource = BookSource.fromJson(json['booksource']);
    name = json['name'];
    author = json['author'];
    cover = json['cover'];
    summary = json['summary'];
    status = json['status'];
    update = json['update'];
    lastChapter = json['lastChapter'];
    readIndex = json['readIndex'];
    if (json['chapter'] != null) {
      chapters = new List<Chapter>();
      json['chapter'].forEach((v) {
        chapters.add(new Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booksource'] = this.booksource;
    data['name'] = this.name;
    data['author'] = this.author;
    data['cover'] = this.cover;
    data['summary'] = this.summary;
    data['status'] = this.status;
    data['update'] = this.update;
    data['lastChapter'] = this.lastChapter;
    data['readIndex'] = this.readIndex;
    if (this.chapters != null) {
      data['chapter'] = this.chapters.map((c) => c.toJson()).toList();
    }
    return data;
  }
}

class Chapter with ChangeNotifier {
  String name = '';
  bool isread = false;
  bool isload = false;
  List<String> content;

  Chapter({this.name, this.isread, this.isload, this.content});

  Chapter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isread = json['isread'];
    isload = json['isload'];
    content = json['content'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isread'] = this.isread;
    data['isload'] = this.isload;
    data['content'] = this.content;
    return data;
  }
}

List<Book> buildTestBooks() {
  List<String> chapters = [
    "21军演篇 背锅侠",
    "21军演篇 各施神通",
    "21军演篇 前知",
    "21军演篇 赤鬃孽虎",
    "21军演篇 以身饲虎",
    "21军演篇 督军会面",
    "21军演篇 天赐良机",
    "21军演篇 波澜诡谲",
    "重要通知",
    "请假一期",
    "21军演篇 疯狂？",
    "21军演篇 煽风点火",
    "21军演篇 火上浇油",
    "21军演篇 虞旸汤池",
    "21军演篇 吸干了！",
    "21军演篇 挑不动，直接干！",
    "21军演篇 小明VS公鹿",
    "请假一期",
    "21军演篇 器灵凶躯",
    "21军演篇 仲春之会"
  ];

  List<String> contentList = [
    "https://manhua.qpic.cn/manhua_detail/0/11_17_00_1db00d6275c817b31e39c8d952b6f6c8_8280.jpg/0",
    "https://manhua.qpic.cn/manhua_detail/0/11_17_00_1b67c298b209c336e43c713cb045f24f_8281.jpg/0",
    "https://manhua.qpic.cn/manhua_detail/0/11_17_00_d3dd3facfb2527f2c07dc5b370c0cedb_8282.jpg/0",
    "https://manhua.qpic.cn/manhua_detail/0/11_17_00_f87e8a1363c85b1381fa8dff21cd9d7a_8283.jpg/0",
    "https://manhua.qpic.cn/manhua_detail/0/11_17_00_0bf14ed05cab27f25ae31956bb25be31_8284.jpg/0",
  ];

  List<Chapter> chapterList =
      chapters.map((f) => Chapter(name: f, content: contentList)).toList();

  List<Book> bookList = [
    Book(
      name: "驭灵师",
      cover:
          "https://manhua.qpic.cn/vertical/0/02_16_29_781bb66fd0c9bc66308ccf97fd9c244b_1564734550756.jpg/0",
      summary:
          "这是一个漫画家降临自己笔下世界的冒险故事，某知名拖稿能手漫画家因一个神秘电话穿越到了自己的作品里，化身光头配角王小明，身为作者的他怎么会只甘心做个配角！可是就算是造物主又真的能改变最后的命运吗？",
      status: "连载",
      chapters: chapterList,
    ),
    Book(
      name: "鬼医凤九",
      cover:
          "https://manhua.qpic.cn/vertical/0/08_10_35_21431a989e3b5cef1823c0244778fe95_1515378944518.jpg/0",
      summary:
          "这是一个漫画家降临自己笔下世界的冒险故事，某知名拖稿能手漫画家因一个神秘电话穿越到了自己的作品里，化身光头配角王小明，身为作者的他怎么会只甘心做个配角！可是就算是造物主又真的能改变最后的命运吗？",
      status: "连载",
      chapters: chapterList,
    ),
    Book(
      name: "渡劫变成高中生",
      cover:
          "https://manhua.qpic.cn/vertical/0/26_17_35_a95059a889957ec2412bce943d77de05_1564133717644.jpg/0",
      summary:
          "这是一个漫画家降临自己笔下世界的冒险故事，某知名拖稿能手漫画家因一个神秘电话穿越到了自己的作品里，化身光头配角王小明，身为作者的他怎么会只甘心做个配角！可是就算是造物主又真的能改变最后的命运吗？",
      status: "false",
      chapters: chapterList,
    ),
    Book(
      name: "琅寰书院",
      cover:
          "https://manhua.qpic.cn/vertical/0/10_18_36_663c08d4a0d4672d53f8fe7fede78431_1531218989517.jpg/420",
      summary:
          "这是一个漫画家降临自己笔下世界的冒险故事，某知名拖稿能手漫画家因一个神秘电话穿越到了自己的作品里，化身光头配角王小明，身为作者的他怎么会只甘心做个配角！可是就算是造物主又真的能改变最后的命运吗？",
      status: "false",
      chapters: chapterList,
    ),
    Book(
      name: "武炼巅峰",
      cover:
          "https://manhua.qpic.cn/vertical/0/30_17_18_c5599079b82aca6d00c35a02f9d0993c_1535620691678.jpg/420",
      summary:
          "这是一个漫画家降临自己笔下世界的冒险故事，某知名拖稿能手漫画家因一个神秘电话穿越到了自己的作品里，化身光头配角王小明，身为作者的他怎么会只甘心做个配角！可是就算是造物主又真的能改变最后的命运吗？",
      status: "false",
      chapters: chapterList,
    ),
    Book(
      name: "重生之都市修仙",
      cover:
          "https://manhua.qpic.cn/vertical/0/10_15_49_05467b30343910a4fae5462ecd132cd5_1570693792112.jpg/420",
      summary:
          "这是一个漫画家降临自己笔下世界的冒险故事，某知名拖稿能手漫画家因一个神秘电话穿越到了自己的作品里，化身光头配角王小明，身为作者的他怎么会只甘心做个配角！可是就算是造物主又真的能改变最后的命运吗？",
      status: "false",
      chapters: chapterList,
    ),
  ];
  return bookList;
}

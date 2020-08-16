class BookSource {
  String name;
  String url;
  int version;
  Search search;
  Detail detail;
  Catalog catalog;
  Chapter chapter;
  List<Rank> rank;

  BookSource(
      {this.name,
      this.url,
      this.version,
      this.search,
      this.detail,
      this.catalog,
      this.chapter,
      this.rank});

  BookSource.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    version = json['version'];
    search =
        json['search'] != null ? new Search.fromJson(json['search']) : null;
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    catalog =
        json['catalog'] != null ? new Catalog.fromJson(json['catalog']) : null;
    chapter =
        json['chapter'] != null ? new Chapter.fromJson(json['chapter']) : null;
    if (json['rank'] != null) {
      rank = new List<Rank>();
      json['rank'].forEach((v) {
        rank.add(new Rank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['version'] = this.version;
    if (this.search != null) {
      data['search'] = this.search.toJson();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    if (this.catalog != null) {
      data['catalog'] = this.catalog.toJson();
    }
    if (this.chapter != null) {
      data['chapter'] = this.chapter.toJson();
    }
    if (this.rank != null) {
      data['rank'] = this.rank.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Search {
  String url;
  String charset;
  String list;
  String name;
  String author;
  String cover;
  String detail;

  Search(
      {this.url,
      this.charset,
      this.list,
      this.name,
      this.author,
      this.cover,
      this.detail});

  Search.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    charset = json['charset'];
    list = json['list'];
    name = json['name'];
    author = json['author'];
    cover = json['cover'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['charset'] = this.charset;
    data['list'] = this.list;
    data['name'] = this.name;
    data['author'] = this.author;
    data['cover'] = this.cover;
    data['detail'] = this.detail;
    return data;
  }
}

class Detail {
  String name;
  String author;
  String cover;
  String summary;
  String status;
  String update;
  String lastChapter;
  String catalog;

  Detail(
      {this.name,
      this.author,
      this.cover,
      this.summary,
      this.status,
      this.update,
      this.lastChapter,
      this.catalog});

  Detail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    author = json['author'];
    cover = json['cover'];
    summary = json['summary'];
    status = json['status'];
    update = json['update'];
    lastChapter = json['lastChapter'];
    catalog = json['catalog'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['author'] = this.author;
    data['cover'] = this.cover;
    data['summary'] = this.summary;
    data['status'] = this.status;
    data['update'] = this.update;
    data['lastChapter'] = this.lastChapter;
    data['catalog'] = this.catalog;
    return data;
  }
}

class Catalog {
  String list;
  int orderBy;
  String name;
  String chapter;

  Catalog({this.list, this.orderBy, this.name, this.chapter});

  Catalog.fromJson(Map<String, dynamic> json) {
    list = json['list'];
    orderBy = json['orderBy'];
    name = json['name'];
    chapter = json['chapter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list'] = this.list;
    data['orderBy'] = this.orderBy;
    data['name'] = this.name;
    data['chapter'] = this.chapter;
    return data;
  }
}

class Chapter {
  String content;

  Chapter({this.content});

  Chapter.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    return data;
  }
}

class Rank {
  String title;
  String url;
  int page;
  int size;
  String list;
  String name;
  String author;
  String cover;
  String detail;
  List<Categories> categories;

  Rank(
      {this.title,
      this.url,
      this.page,
      this.size,
      this.list,
      this.name,
      this.author,
      this.cover,
      this.detail,
      this.categories});

  Rank.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    page = json['page'];
    size = json['size'];
    list = json['list'];
    name = json['name'];
    author = json['author'];
    cover = json['cover'];
    detail = json['detail'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['page'] = this.page;
    data['size'] = this.size;
    data['list'] = this.list;
    data['name'] = this.name;
    data['author'] = this.author;
    data['cover'] = this.cover;
    data['detail'] = this.detail;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String key;
  String value;

  Categories({this.key, this.value});

  Categories.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

/*{
    "name": "SF轻小说",
    "url": "book.sfacg.com",
    "version": 101,
    "search": {
        "url": "http://s.sfacg.com/?Key=${key}&S=1&SS=0",
        "charset": "utf-8",
        "list": "ul",
        "name": "li:nth-child(2) > strong",
        "author": "li:nth-child(2)@match->(?<=综合信息： )(.+)(?=/[0-9]{4}/)",
        "cover": "img",
        "detail": "li:nth-child(2) > strong > a"
    },
    "detail": {
        "name": ".title > span:nth-child(1)",
        "author": ".author-name",
        "cover": ".left-part > .figure > .pic > a > img",
        "summary": ".introduce", 
        "status": ".count-detail > div:nth-child(1) > span:nth-child(2)@match->(?<=\\[)(.+)(?=\\])",
        "update": ".count-detail > div:nth-child(2) > span@match->(?<=更新：)(.+)",
        "lastChapter": ".chapter-info > h3 > a",
        "catalog": ".btn-row > a:nth-child(1)"
    },
    "catalog": {
        "list": ".story-catalog",
        "orderBy": 0,
        "name": "a@attr->title",
        "chapter": "a"
    },
    "chapter": {
        "content": ".article-content"
    },
    "rank": [
        {
            "title": "人气榜",
            "url": "https://m.sfacg.com/rank/original.html",
            "page": 1,
            "size": 20,
            "list": "ul.book_list",
            "name": "#listtitle",
            "author": "a > li:nth-child(2) > div:nth-child(3)@match->(.+)(?= /)",
            "cover": "img",
            "detail": "a@attr->href@replace->m.sfacg.com/b/->book.sfacg.com/Novel/"
        },
        {
            "title": "全部",
            "url": "http://book.sfacg.com/List/default.aspx?tid=${key}&PageIndex=${page}",
            "page": 1,
            "size": 20,
            "categories": [
                {"key": "-1", "value": "全部"}, {"key": "21", "value": "魔幻"},
                {"key": "22", "value": "玄幻"}, {"key": "23", "value": "古风"}, 
                {"key": "24", "value": "科幻"}, {"key": "25", "value": "校园"}, 
                {"key": "26", "value": "都市"}, {"key": "27", "value": "游戏"},
                {"key": "28", "value": "同人"}, {"key": "29", "value": "悬疑"}
            ],
            "list": ".Comic_Pic_List",
            "author": ".Comic_Pic_List > li:nth-child(2) > a"
        }
    ]
}*/

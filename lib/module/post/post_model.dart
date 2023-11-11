class GetAllPostsModel {
  bool? success;
  List<Data>? data;

  GetAllPostsModel({required this.success, required this.data});

  GetAllPostsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? author;
  String? contents;
  String? name;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? likeCount;

  Data(
      {
        this.id,
        this.author,
        this.contents,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.title,
        this.likeCount,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    author = json['author'];
    contents = json['contents'];
    name = json['name'];
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    likeCount = json['likeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['author'] = this.author;
    data['contents'] = this.contents;
    data['name'] = this.name;
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['likeCount'] = this.likeCount;
    return data;
  }
}

class PostingModel {
  String? author;
  String? name;
  String? title;
  String? contents;

  PostingModel(this.author, this.contents,this.name,this.title);

  PostingModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    name = json['name'];
    title = json['title'];
    contents = json['contents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['name'] = this.name;
    data['title'] = this.title;
    data['contents'] = this.contents;
    return data;
  }
}

class SearchModel {
  String? text;

  SearchModel(this.text);

  Map<String,dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}
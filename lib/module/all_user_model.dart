class GetAllUserDataModel {
  bool? success;
  List<Data>? data;

  GetAllUserDataModel({this.success, this.data});

  GetAllUserDataModel.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? name;
  String? id;
  List<Posts>? posts;

  Data({this.email, this.name, this.id, this.posts});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    id = json['id'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  String? author;
  String? contents;
  String? createdAt;
  String? updatedAt;

  Posts(
      {
        this.author,
        this.contents,
        this.createdAt,
        this.updatedAt,
      });

  Posts.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    contents = json['contents'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['contents'] = this.contents;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
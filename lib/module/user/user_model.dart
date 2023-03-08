class GetUserInfoModel {
  final bool success;
  final Data data;

  GetUserInfoModel({required this.success,required this.data});

  factory GetUserInfoModel.fromJson(Map<String,dynamic> json) {
    return GetUserInfoModel(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final String id;
  final String name;
  final String email;

  Data({required this.id,required this.name,required this.email});

  factory Data.fromJson(Map<String, dynamic> json, ) {
    return Data(
        email: json['email'],
        name: json['name'],
        id: json['id'],
    );
  }
}

class UserAccountModel {
  String email;
  String name;
  String password;

  UserAccountModel(this.email,this.name, this.password);

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'password': password,
  };
}

class ConfirmUserModel {
  String email;
  String password;

  ConfirmUserModel(this.email, this.password);

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class PasswordToJsonModel {
  String password;

  PasswordToJsonModel(this.password);

  Map<String, dynamic> toJson() => {
    'password': password,
  };
}

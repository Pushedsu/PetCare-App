class GetAccessTokenModel {
  final bool success;
  final Data data;

  GetAccessTokenModel({required this.success,required this.data});

  factory GetAccessTokenModel.fromJson(Map<String,dynamic> json) {
    return GetAccessTokenModel(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final String access_token;

  Data({required this.access_token});

  factory Data.fromJson(Map<String, dynamic> json, ) {
    return Data(
        access_token: json['access_token'],
    );
  }
}

class GetLoginTokenModel {
  final bool success;
  final GetLoginTokenModelData data;

  GetLoginTokenModel({required this.success,required this.data});

  factory GetLoginTokenModel.fromJson(Map<String,dynamic> json) {
    return GetLoginTokenModel(
      success: json['success'],
      data: GetLoginTokenModelData.fromJson(json['data']),
    );
  }
}

class GetLoginTokenModelData {
  final String accessToken;
  final String refreshToken;

  GetLoginTokenModelData({required this.accessToken, required this.refreshToken});

  factory GetLoginTokenModelData.fromJson(Map<String, dynamic> json, ) {
    return GetLoginTokenModelData(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
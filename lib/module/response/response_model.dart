class ResIsBoolSuccessModel{
  final bool success;
  ResIsBoolSuccessModel({required this.success});
  factory ResIsBoolSuccessModel.fromJson(Map<String,dynamic> json){
    return ResIsBoolSuccessModel(success: json['success']);
  }
}

class ResIsBoolFail {
  bool? success;
  String? timestamp;
  int? statusCode;
  String? message;
  String? error;

  ResIsBoolFail(
      {this.success,
        this.timestamp,
        this.statusCode,
        this.message,
        this.error});

  ResIsBoolFail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    timestamp = json['timestamp'];
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['timestamp'] = this.timestamp;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class ResIsBoolFailList {
  bool? success;
  String? timestamp;
  int? statusCode;
  List<String>? message;
  String? error;

  ResIsBoolFailList(
      {this.success,
        this.timestamp,
        this.statusCode,
        this.message,
        this.error});

  ResIsBoolFailList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    timestamp = json['timestamp'];
    statusCode = json['statusCode'];
    // JSON 데이터에서 "message" 필드가 문자열 또는 문자열 목록인지 확인
    dynamic messageData = json['message'];
    if (messageData is String) {
      // 문자열인 경우 문자열 필드에 할당
      message = <String>[messageData];
    } else if (messageData is List<dynamic>) {
      // 문자열 목록인 경우 그대로 할당
      message = messageData.cast<String>();
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['timestamp'] = this.timestamp;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}
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

class ResIsBoolFailLIst {
  bool? success;
  String? timestamp;
  int? statusCode;
  List<String>? message;
  String? error;

  ResIsBoolFailLIst(
      {this.success,
        this.timestamp,
        this.statusCode,
        this.message,
        this.error});

  ResIsBoolFailLIst.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    timestamp = json['timestamp'];
    statusCode = json['statusCode'];
    message = json['message'].cast<String>();
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
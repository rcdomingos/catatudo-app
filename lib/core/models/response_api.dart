class ResponseApi {
  int code;
  String message;
  String description;

  ResponseApi({this.code, this.message, this.description});

  ResponseApi.fromJson(Map<dynamic, dynamic> json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['description'] = this.description;
    return data;
  }
}

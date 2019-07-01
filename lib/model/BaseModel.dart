import 'dart:convert';

class BaseModel<T> {
  int status;
  String msg;
  T data;

  BaseModel(this.status, this.msg, this.data);

  BaseModel.fromJson(String jsonString) {
    Map<String, dynamic> data = json.decode(jsonString);
    BaseModel(data['status'], data['msg'], data['data']);
  }
//  BaseModel.fromJson(Map<String, dynamic> json)
//      : status = json['status'],
//        msg = json['msg'],
//        data = json['data'];

  Map<String, dynamic> toJson() {
    return {
        'status': status,
        'msg': msg,
        'data': data,
      };
  }
}

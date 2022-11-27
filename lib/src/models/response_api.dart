import 'dart:convert';

ResponseApi responseApiFromJson(String str) => ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {

  String message;
  String error;
  bool success;
  dynamic data;

  ResponseApi({
    this.message,
    this.error,
    this.success,
  });

  ResponseApi.fromJson(Map<String, dynamic> json) {
    
    message = json["message"];
    error = json["error"];
    success = json["success"];

    try {
      data = json['data'];
    } catch(e) {
      print('Exception data $e');
    }
  }
  
  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "success": success,
    "data": data,
  };
}

/// errors : [{"code":"l_name","message":"The last name field is required."},{"code":"password","message":"The password field is required."}]
library;

class ErrorResponse {
  List<Errors>? error;

  ErrorResponse({this.error});

  ErrorResponse.fromJson(dynamic json) {
    if (json["error"] != null) {
      error = [];
      json["error"].forEach((v) {
        error!.add(Errors.fromJson(v));
      });
    }
  }
}



class Errors {
  String? code;
  String? message;

  Errors({this.code, this.message});

  Errors.fromJson(dynamic json) {
    code = json["code"];
    message = json["message"];
  }
}

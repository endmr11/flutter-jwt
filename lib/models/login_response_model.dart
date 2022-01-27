import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    LoginResponseModel({
        this.message,
        this.data,
    });

    String? message;
    Data? data;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.username,
        this.email,
        this.date,
        this.id,
        this.token,
    });

    String? username;
    String? email;
    DateTime? date;
    String? id;
    String? token;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        email: json["email"],
        date: DateTime.parse(json["date"]),
        id: json["id"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "date": date?.toIso8601String(),
        "id": id,
        "token": token,
    };
}

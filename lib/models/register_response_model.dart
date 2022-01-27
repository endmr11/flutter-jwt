import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
    RegisterResponseModel({
        this.message,
        this.data,
    });

    String? message;
    Data? data;

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
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
    });

    String? username;
    String? email;
    DateTime? date;
    String? id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        email: json["email"],
        date: DateTime.parse(json["date"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "date": date?.toIso8601String(),
        "id": id,
    };
}

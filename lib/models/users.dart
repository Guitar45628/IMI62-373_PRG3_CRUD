// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    int? id;
    String? email;
    String? password;
    String? fullname;
    String? gender;

    Users({
        this.id,
        this.email,
        this.password,
        this.fullname,
        this.gender,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        fullname: json["fullname"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "fullname": fullname,
        "gender": gender,
    };
}

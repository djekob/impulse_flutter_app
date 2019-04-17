import 'package:firebase_database/firebase_database.dart';

class User {
  String name;
  String email;
  String userId;

  User(this.name, this.userId, this.email);

  User.fromSnapshot(DataSnapshot snapshot) :
        userId = snapshot.value["userId"],
        name = snapshot.value["name"],
        email = snapshot.value["email"];

  toJson() {
    return {
      "userId": userId,
      "email": email,
      "name": name,
    };
  }
}
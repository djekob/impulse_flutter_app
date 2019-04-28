import 'package:firebase_database/firebase_database.dart';

class User {
  String _name;
  String _email;
  String _userId;
  String _profilePictureUrl;

  String get name => _name;
  String get email => _email;
  String get userId => _userId;
  String get profilePictureUrl => _profilePictureUrl;

  User(this._name, this._userId, this._email, this._profilePictureUrl);



  User.fromSnapshot(DataSnapshot snapshot) :
        _userId = snapshot.value["userId"],
        _name = snapshot.value["name"],
        _email = snapshot.value["email"],
        _profilePictureUrl = snapshot.value["profilePictureUrl"];

  toJson() {
    return {
      "userId": _userId,
      "email": _email,
      "name": _name,
      "profilePictureUrl": _profilePictureUrl
    };
  }
}
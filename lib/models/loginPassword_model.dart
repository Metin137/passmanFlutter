import 'package:flutter/material.dart';

class LoginPasswordModel {
  int? _id;
  late String _passwordLogin;
  late String _passwordHint;

  LoginPasswordModel(
    this._passwordLogin,
    this._passwordHint,
  );

  int get id => _id!;
  String get passwordLogin => _passwordLogin;
  String get passwordHint => _passwordHint;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['passwordLogin'] = _passwordLogin;
    map['passwordHint'] = _passwordHint;
    debugPrint("map: " + map.toString());
    return map;
  }

  LoginPasswordModel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._passwordLogin = map['passwordLogin'];
    this._passwordHint = map['passwordHint'];
  }
}

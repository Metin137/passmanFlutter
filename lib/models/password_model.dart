class PasswordModel {
  int? _id;
  late String _passwordName;
  late String _passwordLogin;
  late String _password;
  late String _passwordInfo;

  PasswordModel(
    this._passwordName,
    this._passwordLogin,
    this._password,
    this._passwordInfo,
  );

  int get id => _id!;
  String get passwordName => _passwordName;
  String get passwordLogin => _passwordLogin;
  String get password => _password;
  String get passwordInfo => _passwordInfo;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['passwordName'] = _passwordName;
    map['passwordLogin'] = _passwordLogin;
    map['password'] = _password;
    map['passwordInfo'] = _passwordInfo;

    return map;
  }

  PasswordModel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._passwordName = map['passwordName'];
    this._passwordLogin = map['passwordLogin'];
    this._password = map['password'];
    this._passwordInfo = map['passwordInfo'];
  }
}

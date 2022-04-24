import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:passman/models/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/models/password_model.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/utilities/database_helper.dart';
import 'package:passman/widgets/InputBuilder.dart';
import 'package:passman/widgets/KeyboardView.dart';
import 'package:passman/widgets/RoundedButtonBuilder.dart';

class CreatePassScreen extends StatefulWidget {
  final String? screenType;
  final Map<String, dynamic>? item;

  const CreatePassScreen({
    Key? key,
    this.screenType,
    this.item,
  }) : super(key: key);

  @override
  _CreatePassScreenState createState() => _CreatePassScreenState();
}

class _CreatePassScreenState extends State<CreatePassScreen> {
  String? screenType = "";
  String? passwordID = "";

  final passwordName = TextEditingController();
  final passwordLogin = TextEditingController();
  final password = TextEditingController();
  final passwordInfo = TextEditingController();

  late FocusNode passwordNameFocus;
  late FocusNode passwordLoginFocus;
  late FocusNode passwordFocus;
  late FocusNode passwordInfoFocus;

  bool isFocused = true;
  bool passwordNameFocusCheck = false;
  bool passwordLoginFocusCheck = false;
  bool passwordFocusCheck = false;
  bool passwordInfoFocusCheck = false;

  @override
  void initState() {
    super.initState();

    passwordNameFocus = FocusNode();
    passwordLoginFocus = FocusNode();
    passwordFocus = FocusNode();
    passwordInfoFocus = FocusNode();

    if (widget.item?.isNotEmpty ?? false) {
      debugPrint("girme" + (widget.item?.toString() ?? ""));
      setState(() {
        passwordID = widget.item!["id"].toString();
        passwordName.text = widget.item!["passwordName"] ?? "";
        passwordLogin.text = widget.item!["passwordLogin"] ?? "";
        password.text = widget.item!["password"] ?? "";
        passwordInfo.text = widget.item!["passwordInfo"] ?? "";
      });
    }

    setState(() {
      screenType = widget.screenType;
    });

    passwordNameFocus.addListener(() {
      setState(() {
        print("Has focus: ${passwordNameFocus.hasFocus}");
        passwordNameFocusCheck = passwordNameFocus.hasFocus;
      });
    });
    passwordLoginFocus.addListener(() {
      setState(() {
        passwordLoginFocusCheck = passwordLoginFocus.hasFocus;
      });
    });
    passwordFocus.addListener(() {
      setState(() {
        passwordFocusCheck = passwordFocus.hasFocus;
      });
    });
    passwordInfoFocus.addListener(() {
      setState(() {
        passwordInfoFocusCheck = passwordInfoFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    DatabaseHelper.instance.close();
    passwordName.dispose();
    passwordLogin.dispose();
    password.dispose();
    passwordInfo.dispose();

    passwordNameFocus.dispose();
    passwordLoginFocus.dispose();
    passwordFocus.dispose();
    passwordInfoFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeColors theme = context.watch<ThemesProvider>().getColors;
    TextTheme mainTextTheme = Theme.of(context).textTheme;
    isFocused = passwordNameFocusCheck || passwordLoginFocusCheck || passwordFocusCheck || passwordInfoFocusCheck;

    print('unFocused' + passwordNameFocus.hasFocus.toString());
    //final data = ModalRoute.of(context)!.settings.arguments as String?;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
          return Future.value(true);
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              iconTheme: IconThemeData(color: theme.white),
              backgroundColor: theme.primary,
              title: Center(
                child: Text(
                  'Yeni Parola',
                  style: mainTextTheme.headline1,
                ),
              ),
              actions: [Container(width: 50)],
            ),
            body: KeyboardView(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...buildTopWidgets,
                  Spacer(),
                  screenType == "view" && !isFocused ? buildBottomButtonsForView() : buildBottomButtonsForCreate(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSave() async {
    if (screenType == "create") {
      int res = await DatabaseHelper.instance.addPassword(
        PasswordModel(
          passwordName.text,
          passwordLogin.text,
          password.text,
          passwordInfo.text,
        ),
      );
      var snackBar = SnackBar(content: const Text('kaydedildi'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print('passID' + passwordID!);
      int res = await DatabaseHelper.instance.updatePassword(
        passwordID!,
        PasswordModel(
          passwordName.text,
          passwordLogin.text,
          password.text,
          passwordInfo.text,
        ),
      );
      var snackBar = SnackBar(content: const Text('Güncellendi'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context, true);
      return Future.value(true);
    }
  }

  Row buildBottomButtonsForView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RoundedButtonBuilder(
          icon: Entypo.pencil,
          onPressed: () {
            setState(() {
              screenType = passwordID != null ? "update" : "create";
            });

            passwordNameFocus.requestFocus();
          },
        ),
        RoundedButtonBuilder(icon: Entypo.share),
        RoundedButtonBuilder(
          icon: Icons.delete,
          onPressed: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Uyarı'),
                  content: Text('Silinsin mi?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Evet'),
                      onPressed: () async {
                        int res = await DatabaseHelper.instance.deletePassword(passwordID!);
                        var snackBar = SnackBar(content: const Text('Silindi'));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                        Navigator.pop(context, true);
                        return Future.value(true);
                      },
                    ),
                    TextButton(
                      child: const Text('İptal'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Row buildBottomButtonsForCreate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RoundedButtonBuilder(icon: Entypo.save, onPressed: onSave),
        RoundedButtonBuilder(
          icon: Icons.cancel,
          onPressed: () async {
            if (passwordID != "") {
              debugPrint("pas: " + (passwordID ?? ""));
              passwordNameFocus.unfocus();
              passwordLoginFocus.unfocus();
              passwordFocus.unfocus();
              passwordInfoFocus.unfocus();

              setState(() {
                screenType = "view";
              });
            } else {
              Navigator.pop(context, true);
            }
          },
        ),
      ],
    );
  }

  List<Widget> get buildTopWidgets {
    return [
      SizedBox(height: 20),
      InputBuilder(
        text: "Parola İsmi",
        borderRadius: 6,
        controller: passwordName,
        focusNode: passwordNameFocus,
      ),
      SizedBox(height: 3),
      InputBuilder(
        text: "Kullanıcı Adı",
        borderRadius: 6,
        controller: passwordLogin,
        focusNode: passwordLoginFocus,
      ),
      SizedBox(height: 3),
      InputBuilder(
        text: "Şifre",
        borderRadius: 6,
        controller: password,
        focusNode: passwordFocus,
      ),
      SizedBox(height: 3),
      InputBuilder(
        text: "Ek Bilgi",
        borderRadius: 6,
        multiline: true,
        controller: passwordInfo,
        focusNode: passwordInfoFocus,
      ),
    ];
  }
}

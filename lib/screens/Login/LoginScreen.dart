import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/models/loginPassword_model.dart';
import 'package:passman/screens/PassList/PassListScreen.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/utilities/database_helper.dart';
import 'package:passman/widgets/CardBuilder.dart';
import 'package:passman/widgets/InputBuilder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passman/route/route.dart' as route;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String passwordLogin = '', password = '', rePassword = '';
  bool isFirst = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkLoginPassword();
  }

  @override
  void dispose() {
    DatabaseHelper.instance.close();
    super.dispose();
  }

  passwordLoginOnChanged(String arg) {
    passwordLogin = arg;
  }

  passwordOnChanged(String arg) {
    password = arg;
  }

  rePasswordOnChanged(String arg) {
    rePassword = arg;
  }

  onConfirm() async {
    SnackBar snackBar;
    if (isFirst) {
      if (password == rePassword) {
        int result = await DatabaseHelper.instance
            .addLoginPassword(LoginPasswordModel(passwordLogin, password));
        snackBar = SnackBar(content: const Text('Oluşturuldu'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        checkLoginPassword();
      } else {
        snackBar = SnackBar(content: const Text('Şifreler uyuşmuyor.'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.of(context).pushNamedAndRemoveUntil(
          route.List,
          (route) => false,
        );
      }
    } else {
      bool result = await DatabaseHelper.instance.checkLoginPassword(password);

      if (result) {
        snackBar = SnackBar(content: const Text('Giriş Başarılı'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pushNamedAndRemoveUntil(
          context,
          route.List,
          (route) => false,
        );
      } else {
        snackBar = SnackBar(content: const Text('Yanlış Şifre'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  checkLoginPassword() async {
    bool result = await DatabaseHelper.instance.checkLoginPasswordCount();

    setState(() {
      isFirst = !result;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map theme = context.watch<ThemesProvider>().getColors;
    TextTheme mainTextTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme["primary"],
          title: Center(
            child: Text(
              'Parola Gir',
              style: mainTextTheme.headline1,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 600.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isFirst
                    ? CardBuilder(
                        title: "Yeni Parola Oluştur",
                        onConfirm: onConfirm,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              InputBuilder(
                                text: "Parola",
                                onChanged: passwordLoginOnChanged,
                              ),
                              SizedBox(height: 3),
                              InputBuilder(
                                text: "Parola Tekrarı",
                                onChanged: passwordOnChanged,
                              ),
                              SizedBox(height: 3),
                              InputBuilder(
                                text: "İpucu",
                                onChanged: rePasswordOnChanged,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )
                    : CardBuilder(
                        title: "Giriş Parolanızı Giriniz",
                        buttonText: "Giriş Yap",
                        onConfirm: onConfirm,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              InputBuilder(
                                text: "Parola",
                                onChanged: passwordOnChanged,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

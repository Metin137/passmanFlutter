import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passman/models/password_model.dart';
import 'package:passman/models/theme_model.dart';
import 'package:passman/utilities/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/widgets/ListItemBuilder.dart';
import 'package:passman/route/route.dart' as route;
import 'package:path/path.dart';

Future<File> convertFile(String path) async {
  return File('$path');
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeColors theme = context.watch<ThemesProvider>().getColors;
    TextTheme mainTextTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.primary,
            title: Center(
              child: Text(
                'Ayarlar',
                style: mainTextTheme.headline1,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListItemBuilder(
                  icon: Icons.lock,
                  title: 'Şifreyi değiştir',
                ),
                ListItemBuilder(
                  icon: Icons.language,
                  title: 'Dil değiştir',
                ),
                ListItemBuilder(
                  icon: Icons.dark_mode,
                  title: 'Temayı değiştir',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      route.ThemeAndLAnguage,
                    );
                  },
                ),
                ListItemBuilder(
                  icon: Icons.backup,
                  title: 'Yedekle',
                  onPressed: () => exportPasswords(),
                ),
                ListItemBuilder(
                  icon: Icons.restore,
                  title: 'Geri yükle',
                  onPressed: () => importPasswords(context: context),
                ),
                ListItemBuilder(
                  icon: Icons.import_export,
                  title: 'Dışarı aktar',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void exportPasswords() async {
    Directory? passwordFileDirectory = Platform.isAndroid ? await getExternalStorageDirectory() : await getLibraryDirectory();
    File passwordFile = await convertFile(join(passwordFileDirectory!.path, "passwords.txt"));
    List list = await DatabaseHelper.instance.getAllPassword();
    await passwordFile.create(recursive: true);
    await passwordFile.writeAsString(jsonEncode(list));
  }

  void importPasswords({required context}) async {
    Directory? passwordFileDirectory = Platform.isAndroid ? await getExternalStorageDirectory() : await getLibraryDirectory();
    File passwordFile = await convertFile(join(passwordFileDirectory!.path, "passwords.txt"));

    if ((await passwordFile.exists())) {
      String response = await passwordFile.readAsString();
      var allPasswords = jsonDecode(response);
      await DatabaseHelper.instance.deleteAllPassword();
      allPasswords.forEach((val) async {
        await DatabaseHelper.instance.addPassword(
          PasswordModel.fromMap(val),
        );
      });

      var snackBar = SnackBar(content: const Text('Geri yüklendi'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/widgets/ListItemBuilder.dart';
import 'package:passman/route/route.dart' as route;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
              ),
              ListItemBuilder(
                icon: Icons.restore,
                title: 'Geri yükle',
              ),
              ListItemBuilder(
                icon: Icons.import_export,
                title: 'Dışarı aktar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

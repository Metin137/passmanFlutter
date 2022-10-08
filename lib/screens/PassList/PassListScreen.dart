import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passman/models/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/models/password_model.dart';
import 'package:passman/screens/CreatePassword/CreatePassScreen.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/utilities/database_helper.dart';
import 'package:passman/widgets/CustomElevatedButton.dart';
import 'package:passman/widgets/InputBuilder.dart';
import 'package:passman/widgets/KeyboardView.dart';
import 'package:passman/widgets/RoundedButtonBuilder.dart';
import 'package:passman/widgets/ListItemBuilder.dart';
import 'package:passman/route/route.dart' as route;

class PassListScreen extends StatefulWidget {
  const PassListScreen({Key? key}) : super(key: key);

  @override
  _PassListScreenState createState() => _PassListScreenState();
}

class _PassListScreenState extends State<PassListScreen> {
  List passwordList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPasswordList();
  }

  @override
  Widget build(BuildContext context) {
    ThemeColors theme = context.watch<ThemesProvider>().getColors;
    TextTheme mainTextTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: theme.primary,
          title: Center(
            child: Text(
              'Parolalar',
              style: mainTextTheme.headline1,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  route.Settings,
                );
                if (result != null) {
                  getPasswordList();
                }
              },
              icon: Icon(Icons.settings),
            )
          ],
        ),
        floatingActionButton: buildFloatingActionButton(theme),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: passwordList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListItemBuilder(
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  route.PassCreate,
                  arguments: {"screenType": "view", "item": passwordList[index]},
                );

                if (result != null) {
                  getPasswordList();
                }
              },
              icon: Icons.lock,
              title: passwordList[index]?["passwordName"] ?? '',
              rightIcon: false,
              description: passwordList[index]?["passwordInfo"] ?? '',
            );
          },
        ),
      ),
    );
  }

  void getPasswordList() async {
    List list = await DatabaseHelper.instance.getAllPassword();

    setState(() {
      passwordList = list;
    });
  }

  CustomElevatedButton buildFloatingActionButton(ThemeColors theme) {
    return CustomElevatedButton(
      onPressed: () async {
        final result = await Navigator.pushNamed(context, route.PassCreate, arguments: {"screenType": "create"});

        if (result != null) {
          getPasswordList();
        }
      },
      padding: EdgeInsets.all(15),
      color: theme.fourth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2000)),
      ),
      child: Icon(
        Icons.add,
        size: 35,
        color: theme.secondary,
      ),
    );
  }

  Text buildTitle(ThemeColors theme) {
    return Text(
      "parola",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: theme.textColor,
      ),
    );
  }
}

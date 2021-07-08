import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/utilities/bloc_theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

//import 'package:passman/utilities/bloc_theme.dart';
//import 'package:passman/utilities/themes.dart';
//import 'package:passman/utilities/customColorScheme.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map theme =
        BlocProvider.of<ThemesDataCubit>(context, listen: true).getColors;

    TextTheme mainThemeData = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme["primary"],
        title: Center(
          child: Text(
            'Parola Oluştur',
            style: mainThemeData.headline1,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10, right: 10),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: theme["primary"],
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme["fivetiary"],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    padding:
                        EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 45),
                    child: Text(
                      'Yeni Parola Oluştur',
                      style: mainThemeData.bodyText1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 10.h,
                color: theme["secondary"],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      //color: Theme.of(context).colorScheme.accent,
                      child: Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Parola',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      color: BlocProvider.of<ThemesDataCubit>(context,
                              listen: true)
                          .getColors['primary'],
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'giriniz...', border: InputBorder.none),
                      ),
                    )),
                  ],
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Provider.of<ThemesProvider>(context, listen: false)
                            .changeT();
                      },
                      child: Text(
                        'Provider',
                        style: TextStyle(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<BlocTheme>(context)
                            .add(SupportedTheme.TOGGLE);
                      },
                      child: Text(
                        'Bloc',
                        style: TextStyle(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () {
                        context.read<ThemesDataCubit>().toggleThemes();
                      },
                      child: Text(
                        'Cubit',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}

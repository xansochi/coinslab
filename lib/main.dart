import 'package:flutter/material.dart';
import 'pages/auth_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import './const/themes_const.dart';
import 'package:provider/provider.dart';
import 'provider/news_provider.dart';
import './provider/user_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Coin Application',
      theme: FlexThemeData.light(scheme: FlexScheme.amber,useMaterial3: true,fontFamily: 'Inter',
         colors: FlexSchemeColor(
          primary: ThemesConstants.primaryColor,
          secondary: const Color(0xffac3306),
          // secondaryContainer: Color(0xffffdbcf),
          // tertiary: Color(0xff006875),
          // tertiaryContainer: Color(0xff95f0ff),
          // appBarColor: Color(0xffffdbcf),
          // error: Color(0xffb00020),
      ),),

      darkTheme: FlexThemeData.dark(scheme: FlexScheme.outerSpace,useMaterial3: true,fontFamily: 'Inter'),

      themeMode: ThemeMode.light,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 1, 62, 102)),
      //   useMaterial3: true,
      //   fontFamily: 'Inter',
      // ),
      home: const AuthPage(),
    ));
  }
}
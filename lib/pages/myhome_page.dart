import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../components/Modal/modal_main.dart';
import '../const/themes_const.dart';
import '../screens/page_info.dart';
import '../screens/page_portfolio.dart';
import '../screens/page_dashboard.dart';
import '../UI/appbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,required this.title});
  final String title;
  // final String jwt;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String jwt = context.watch<UserProvider>().userJwt;
  int currentPageIndex = 0;
    void dataOnTap () {
        log(context.read<UserProvider>().userJwt);
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(backgroundColor :const Color.fromARGB(255, 148, 0, 32),message:context.read<UserProvider>().userJwt));
    }
  @override
  Widget build(BuildContext context) {
        
    return Scaffold(
      appBar: MainAppBar(title: widget.title), // Appbar import from UI path
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: ThemesConstants.navigationIndicatorColor,
        // indicatorColor: Colors.amberAccent,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home,color: ThemesConstants.navigationIndicatorIconActive,),
            icon: const Icon(Icons.home_outlined),
            label: 'Дашборд',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.currency_bitcoin_sharp,color: ThemesConstants.navigationIndicatorIconActive,),
            icon: const Icon(Icons.currency_bitcoin_rounded),
            label: 'Портфель',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school,color: ThemesConstants.navigationIndicatorIconActive),
            icon: const Icon(Icons.school_outlined),
            label: 'Инфо',
          ),
        ],
      ),
      body:

      <Widget?>
        [
        const PageDashboard(),    // 1 screen
        const PagePortfolio(),    // 2 screen
        const PageInfo(),         // 3 screen
        ]
        [currentPageIndex],

      floatingActionButton: const ModalButton(),       // modal window button
      // bottomSheet:IconButton(                          // navigation menu small button
      //     icon: const Icon(Icons.update_sharp),
      //     tooltip: 'add coin button',
      //     onPressed: ()=> {dataOnTap()},
      //   )
    );
  }
}

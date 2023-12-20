import 'package:flutter/material.dart';
import '../main.dart';
import '../const/themes_const.dart';

class PopupMenuExample extends StatefulWidget {
  const PopupMenuExample({super.key});

  @override
  State<PopupMenuExample> createState() => _PopupMenuExampleState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _PopupMenuExampleState extends State<PopupMenuExample> {
  SampleItem? selectedMenu;
  void signOut(){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyApp()));
    }
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
          initialValue: selectedMenu,
          position:PopupMenuPosition.under,
          elevation:10.00,
          color:ThemesConstants.primaryColor,
          iconColor:const Color.fromARGB(1, 1, 1, 1),
          // Callback that sets the selected popup menu item.
          onSelected: (SampleItem item) {
            setState(() {
              selectedMenu = item;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child:   TextButton.icon(
                label: Text('Профиль',style: TextStyle(color: Colors.yellow[50]),),
                icon: Icon(
                 Icons.accessibility_new_sharp,
                 color: Colors.yellow[50],
                   ),
                onPressed: () {},
              ), 
            ),
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemTwo,
              child:   TextButton.icon(
                label: Text('Настройки',style: TextStyle(color: Colors.yellow[50]),),
                icon: Icon(
                 Icons.settings_applications_sharp,
                 color: Colors.yellow[50],
                   ),
                onPressed: () {},
              ), 
            ),
              PopupMenuItem<SampleItem>(
              value: SampleItem.itemThree,
              child:   TextButton.icon(
                label: Text('Выход',style: TextStyle(color: Colors.yellow[50]),),
                icon: Icon(
                 Icons.logout_sharp,
                 color: Colors.yellow[50],
                   ),
                onPressed: ()=>signOut(),
              ), 
            )
          ],
        );
  }
}

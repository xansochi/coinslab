
import 'package:flutter/material.dart';
import '../api/Portfolio/portfolio_api.dart';
import './appbar_usermenu.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget { // make appbar widget imported // MAGIC

const MainAppBar({super.key,required this.title});
final String title;
// final Map<String, dynamic> data;

 @override
  Size get preferredSize => const Size.fromHeight(60); // make appbar widget imported // MAGIC

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading:true,
        iconTheme:const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        actions: <Widget>[
          // Padding(
          // padding: const EdgeInsets.only(left: 0,bottom: 0),
          // child: SizedBox(
          // child:Column(children: [
          //   Text('Привет ${data["username"]}',style:TextStyle(color: Colors.amber)),
          //   Text(data["email"],style:TextStyle(color: Colors.amber))
          // ]))),
          //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
          Padding(
          padding: const EdgeInsets.all(2.0),
          child: SizedBox(
          height: 60,
          width: 60,
          child:CircleAvatar(
            backgroundImage: const NetworkImage('https://media1.popsugar-assets.com/files/thumbor/msjEO8oq7PWud7pFv_Cm6GR6E-U/0x1:2771x2772/fit-in/500x500/filters:format_auto-!!-:strip_icc-!!-/2020/03/30/878/n/1922398/eb11f12e5e825104ca01c1.02079643_/i/Robert-Downey-Jr.jpg'),
          child: 
            Stack(
            children: [const PopupMenuExample(),
            const Positioned(
              left: 0.0,
              top: 35.0,
              child:SizedBox(
                  // child:Text('${data["username"]}',style: TextStyle(color: ThemesConstants.floatingActionButtonColor,fontSize: 12,backgroundColor:ThemesConstants.primaryColor))),
                  child:Text(''),
                    )),
           Padding(
          padding: const EdgeInsets.only(left: 36,bottom: 36),
          child:SizedBox(
          height: 12,
          width: 12,
          child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
          backgroundColor:MaterialStateProperty.all(statusCode == 500 ? const Color.fromARGB(255, 175, 76, 76) : const Color.fromARGB(255, 33, 243, 103),),
          ), child: null,))),
          ],
),
          ))
          ,)
          //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        ],
        centerTitle:true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title,style:const TextStyle(color: Color.fromARGB(255, 228, 228, 228),fontSize: 16),textAlign:TextAlign.center),
      );
  }
}
import 'package:CoinsLab/provider/coinlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'coinlist_rainbow.dart';
import '../../const/themes_const.dart';

class MyList extends StatefulWidget {
    const MyList({ super.key });

  @override
  MyListState createState() => MyListState();
}

class MyListState extends State<MyList> {
  TextEditingController txtQuery = TextEditingController();

  @override // this is provider state preload 
  void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  Provider.of<CoinListProvider>(context, listen: false).getAllCoins();
  });
  }

  @override
  Widget build(BuildContext context) {
  return Consumer<CoinListProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return 
  Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8)
              ),
              boxShadow: [
              BoxShadow(
              color: const Color.fromARGB(255, 182, 182, 182).withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
              ),
              ],
              ),
              margin: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox( 
                    height: 40,
                    child: 
                  TextFormField(
                    style: const TextStyle(fontSize: 14),
                    controller: txtQuery,
                    onChanged: value.setSearchData,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 0.4, color: Color.fromARGB(255, 77, 77, 77)), 
                        ),
                        labelText: "поиск по названию",
                        labelStyle:const TextStyle(fontSize: 14),
                        floatingLabelStyle:const TextStyle(color: Color.fromARGB(255, 2, 89, 175)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        // isDense: true,
                        // hintText: "поиск по названию",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 3, 80, 168))),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            txtQuery.text = '';
                            value.setSearchData(txtQuery.text);
                          },
                        ),
                    ),
                  )
                  ),
                ],
              ),
            ),
            _listTopInfo(),
            value.isLoading
            ? const Center(heightFactor:10, child: CircularProgressIndicator())
            : _listView()
          ]);
      }
      );
      }

  Widget _listView() {
  return Consumer<CoinListProvider>(
      builder: (context, value, child) {
        final coins = value.getSearchedCoins;
        return Expanded(
    child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: coins.length,
              itemBuilder: (BuildContext context, int index) {
                double percentValue = value.getSearchedCoins[index]["price_change_percentage_24h"]; // make code pure
                String icon = value.getSearchedCoins[index]["image"];                               // make code pure
                return Container(
                                decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4)
              ),
              boxShadow: [
              BoxShadow(
              color: const Color.fromARGB(255, 182, 182, 182).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
              ),
              ],
              ),
                  // decoration:BoxDecoration(border: Border.all(width: 0.2,color: const Color.fromARGB(248, 68, 68, 68)),color: const Color.fromARGB(255, 255, 255, 255)),
                  height: 55,
                  child:
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment : CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                          child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment : CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding (
                            padding: const EdgeInsets.only(left:5, bottom: 0, right: 0, top:0),
                            child: Text('${index+1}',style: const TextStyle(height: 5, fontSize: 10),),
                          ),
                            Padding (
                            padding: const EdgeInsets.only(left:12, bottom: 0, right: 0, top:0),
                            child:Image.network(icon,width:36,))
                          ],) 
                          ),
                          Expanded(
                            child:Column(
                              mainAxisAlignment:MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text('${value.getSearchedCoins[index]['name']}',style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 12),),
                                  Text('${value.getSearchedCoins[index]['symbol'].toUpperCase()}',style: const TextStyle(color: Color.fromARGB(255, 116, 115, 115),fontSize: 12),),
                            ],)
                            
                          ),
                          Expanded(
                            child: Padding (padding: const EdgeInsets.only(left:0, bottom: 0, right: 0, top:0), child: RainbowText(dataFromChild:value.getSearchedCoins[index]["current_price"]),
                            // child: Padding (padding: const EdgeInsets.only(left:0, bottom: 0, right: 0, top:0), child: Text('\$${searchedCoins[index]["current_price"]}'),
                            ),
                          ),
                            Expanded(
                            child: Padding (padding: const EdgeInsets.only(left:0, bottom: 0, right: 0, top:0),
                            child: Text('${percentValue.toStringAsFixed(2)} %',
                            style: percentValue < 0 ? const TextStyle(color: Color.fromARGB(255, 153, 1, 1)) : const TextStyle(color: Color.fromARGB(255, 26, 153, 1)) ),
                            ),
                          ),
                        ],
                      ),
                            );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(thickness:1,color:Color.fromARGB(0, 3, 64, 114)),
            ),
        );
      }
    );
  }

    Widget _listTopInfo() {
  return Container(
                  decoration:BoxDecoration(
                  // border: Border.all(width: 20,color: Color.fromARGB(248, 23, 25, 134)),
                  color: ThemesConstants.primaryColor),
                  height: 20,
                  child:
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment : CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                          child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment : CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding (
                            padding: const EdgeInsets.only(left:40, bottom: 0, right: 0, top:0),
                            child: Icon(Icons.now_widgets_sharp,color: ThemesConstants.coinListInfoColor,size:14.0),
                          ),
                            const Padding (
                            padding: EdgeInsets.only(left:12, bottom: 0, right: 0, top:0),
                            child:Text(''))
                          ],) 
                          ),
                          Expanded(
                            child: Padding (
                            padding: const EdgeInsets.only(left:6, bottom: 0, right: 0, top:0),
                            child: Text('название',style: TextStyle(height: 0, fontSize: 12,color: ThemesConstants.coinListInfoColor),),
                          ),
                          ),
                          Expanded(
                            child: Padding (
                            padding: const EdgeInsets.only(left:10, bottom: 0, right: 0, top:0),
                            child: Text('цена',style: TextStyle(height: 0, fontSize: 12,color: ThemesConstants.coinListInfoColor),),
                          ),
                          ),
                          Expanded(
                            child: Padding (
                            padding: const EdgeInsets.only(left:7, bottom: 0, right: 0, top:0),
                            child: Text('24H%',style: TextStyle(height: 0, fontSize: 12,color: ThemesConstants.coinListInfoColor),),
                          ),
                          ),
                        ],
                      ),
                            );
              }
}
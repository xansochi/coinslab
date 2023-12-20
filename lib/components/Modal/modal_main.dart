// ignore_for_file: unused_field

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../../mock/mockList.dart';
import '../../components/Modal/modal_add_coin.dart';
import '../../const/themes_const.dart';
import '../../api/constants_api.dart';



class ModalButton extends StatefulWidget {

  const ModalButton({super.key});

  @override
  ModalButtonState createState() => ModalButtonState();
}

class ModalButtonState extends State<ModalButton> {
  List mainViewList = []; 
  List original = [];
  Map? coinsFromApi;
  String? dataUrlState = ConstantsForApi.getCoinDataUrl;
  bool updateData = false;

// ----------------------------
  TextEditingController txtQuery = TextEditingController();
// ----------------------------
  void loadData() async {
    mainViewList = coinsIdList;
    original = coinsIdList;
    setState(() {});
  }
// ----------------------------
  void search(String query) {
    if (query.isEmpty) {
      mainViewList = original;
      setState(() {});
      return;
    }
    query = query.toLowerCase();
    List result = [];
    for (var p in mainViewList) {
      var name = p["name"].toString().toLowerCase();
      if (name.contains(query)) {
        result.add(p);
      }
    }
    mainViewList = result;
    setState(() {});
  }
// ----------------------------
Future<void> fetchCoinByIdFromIDlist() async {
    final response = await http.get(Uri.parse(dataUrlState!));
    if (response.statusCode == 200) {
      print(response.statusCode);
      Map jsonData = json.decode(response.body);
      setState(() {
        coinsFromApi = jsonData;
      });
    } else {
      print("ERROR. Cant get coin by id");
    }
  }
// ----------------------------
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return 
    FloatingActionButton(
        backgroundColor: ThemesConstants.floatingActionButtonColor,
        onPressed: ()=>{_dialogBuilder(context)},
        tooltip: 'Modal',
        child: Icon(Icons.add_circle_outline_sharp,color: ThemesConstants.floatingActionButtonCircleColor),
      );
  }

  Future<String?> _dialogBuilder(BuildContext context) {
    return showDialog<String>(
            context: context,
            builder: (BuildContext context) { 
              return Dialog.fullscreen(
              child: Container(
                width: MediaQuery.of(context).size.width, 
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0))
        ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox( 
                height: 20,
                child: ElevatedButton(
                  child: const Text('свернуть окно'),
                  onPressed: () => Navigator.pop(context),
                )),
                SizedBox(height:10,child:Container(color: const Color.fromARGB(255, 255, 255, 255),)),
                SizedBox( 
                    height: 40,
                    width: 380,
                    child: 
                        TextFormField(
                          style: const TextStyle(fontSize: 14,backgroundColor:Color.fromARGB(248, 255, 255, 255)),
                          controller: txtQuery,
                          onChanged: search,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 0.4, color: Color.fromARGB(255, 4, 44, 104)), 
                              ),
                              labelText: "Выберите актив",
                              labelStyle:const TextStyle(fontSize: 14),
                              floatingLabelStyle:const TextStyle(color: Color.fromARGB(255, 2, 89, 175)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                  search(txtQuery.text);
                                },
                              ),
                          ),
                        )
                  ),
                  const SizedBox(height:8),
                  SizedBox(height:120, child:
                _listView(mainViewList)),
                ModalAddCoin(coinsFromApi: coinsFromApi)
              ],
            )
              ),
            );},
          );
  }

  ListView _listView(mainViewList){
  return ListView.separated(
            padding: const EdgeInsets.all(6),
            itemCount: mainViewList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
             onTap: () {
              print("button pressed");
              print(mainViewList[index]['id']);
              setState(() { dataUrlState = 'https://api.coingecko.com/api/v3/coins/${mainViewList[index]['id']}?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false';
              print(dataUrlState);
              fetchCoinByIdFromIDlist();
              // setState(() {});
            });
            },
            child:
              Container(
                decoration:BoxDecoration(border: Border.all(width: 0.3,color: const Color.fromARGB(255, 28, 64, 119)),
                color: const Color.fromARGB(255, 243, 243, 243)),
                height: 30,
                child:
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment : CrossAxisAlignment.center,
                      children: <Widget>[                
                        Expanded(
                          child: 
                          Flex(direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment : CrossAxisAlignment.center,
                          children: [
                          const Padding(padding:EdgeInsets.only(left:10, bottom: 5, right: 0, top:5),
                                child: Icon(Icons.add,color:Color.fromARGB(255, 28, 64, 119),size: 25,)),
                          Padding(padding:const EdgeInsets.only(left:10, bottom: 5, right: 0, top:5),
                                child:Text('${mainViewList[index]['symbol'].toUpperCase()}',style: const TextStyle(color: Color.fromARGB(255, 28, 64, 119)))),
                          Padding(padding:const EdgeInsets.only(left:10, bottom: 5, right: 10, top:5),
                                child:Text('( ${mainViewList[index]['name'].length > 15 ? mainViewList[index]['name'].substring(0, 15)
                                : mainViewList[index]['name']} )',style: const TextStyle(color: Color.fromARGB(255, 41, 41, 41))),),
                          ],
                          )
                        )
                      ],
                    ),
                          )
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(thickness:0,color:Color.fromARGB(244, 37, 75, 105)),
          );
              }
}
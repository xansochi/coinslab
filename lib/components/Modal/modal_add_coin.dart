// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:provider/provider.dart';
import '../../api/Modal/modalUpdate_api.dart';
import '../../provider/user_provider.dart';

class ModalAddCoin extends StatefulWidget {
  final Map<dynamic, dynamic>? coinsFromApi;
  const ModalAddCoin({ super.key,required this.coinsFromApi});

  @override
  ModalAddCoinState createState() => ModalAddCoinState();
}
class ModalAddCoinState extends State<ModalAddCoin> {
  // ----------------------------
  final TextEditingController _idController = TextEditingController();
  static TextEditingController coinController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  static TextEditingController quanityController = TextEditingController(text: '1');
  static TextEditingController summController = TextEditingController(text: '1');
  final TextEditingController _idcoinController = TextEditingController();
  final TextEditingController _incomecoinController = TextEditingController();
  static TextEditingController currentpriceController = TextEditingController();
  final TextEditingController _iconcoinController = TextEditingController();
  // ----------------------------
  Map coinBlank = {'id': 'fPNpsrs3PKTDnZtGGBk0B', 'coin': 'Tempocoin', 'price': '0.00',
  'quanity':'1.00', 'summ': '1.00', 'date': '2023-06-12T14:19:16.952Z', 'idcoin': 'idCoin',
  'income': '1.00', 'currentprice': '20000.00', 'icon':'https://assets.coingecko.com/coins/images/738/small/eos-eos-logo.png?1696501893'};
  // ----------------------------

  @override
  
  Widget build(BuildContext context) {
  dynamic userJwt = context.read<UserProvider>().userJwt;
  dynamic userName = context.read<UserProvider>().userName;
    Map coinForApiPut = {"id": nanoid(), "coin": "", "price": currentpriceController.text,
    "quanity":quanityController.text, "summ": summController.text, "date": "2023-06-12T14:19:16.952Z", "idcoin": "ApiCoin",
    "income": "0", "currentprice": currentpriceController.text, "icon":"https://assets.coingecko.com/coins/images/738/small/eos-eos-logo.png?1696501893"};

    coinForApiPut['coin'] = widget.coinsFromApi?['name'];
    coinForApiPut['date'] = DateTime.now().toIso8601String();
    coinForApiPut['idcoin'] =  widget.coinsFromApi?['id'];
    coinForApiPut['icon'] = widget.coinsFromApi?['image']['small'];
    print('---=-=-=-API=-=--=-----');
    print(coinForApiPut);
    print('---=-=-=-API=-=--=-----');

    return Padding (
    padding: const EdgeInsets.only(left:4, bottom: 0, right: 4, top:10),
    child:
    Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment : CrossAxisAlignment.center,
    children: [
          Stack (
            alignment:AlignmentDirectional.centerEnd,
            children: [
            SizedBox(width: 380,height: 60,
            child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: TextFormField(
              controller: currentpriceController,
              keyboardType:TextInputType.number,
              style:const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 126, 126, 126)), 
                  ),
                  labelText: "цена на момент покупки",
                  labelStyle:TextStyle(fontSize: 10),
                  floatingLabelStyle:TextStyle(color: Color.fromARGB(255, 2, 97, 151)),
                  contentPadding: EdgeInsets.symmetric(vertical:0, horizontal: 10),
                  prefixIcon: Icon(Icons.price_check),
              ),
            ),
          )),
          SizedBox(width: 90,height: 40,
            child:
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: ElevatedButton(
            style: ElevatedButton.styleFrom(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // <-- Radius
              ),
              elevation: 0,
                backgroundColor: const Color.fromARGB(255, 36, 120, 177),
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
              child: const Text('узнать цену',selectionColor:Color.fromARGB(255, 255, 255, 255),textAlign:TextAlign.center,
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 12),),
                onPressed:(){
                  setState(() {
                  currentpriceController.text = widget.coinsFromApi != null ?
                  widget.coinsFromApi!['market_data']['current_price']['usd'].toString() : coinBlank['currentprice'];
                  quanityController.text = (double.parse(summController.text) / double.parse(currentpriceController.text)).toString();
                  });
            })))
          ])
            ,
// second input field                    
            SizedBox(width: 380,height: 60,
            child:
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: TextFormField(
              controller: quanityController,
              keyboardType:TextInputType.number,
              style:const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 126, 126, 126)), 
                  ),
                  labelText: "введите количество",
                  labelStyle:TextStyle(fontSize: 10),
                  floatingLabelStyle:TextStyle(color: Color.fromARGB(255, 2, 89, 175)),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  prefixIcon: Icon(Icons.ad_units),
              ),
            ),
          )),

// third input field                    
                      Stack (
            alignment:AlignmentDirectional.centerEnd,
            children: [
              SizedBox(width: 380,height: 60,
            child:
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: TextFormField(
              controller: summController,
              keyboardType:TextInputType.number,
              style:const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 126, 126, 126)), 
                  ),
                  labelText: "или сумму в USD",
                  labelStyle:TextStyle(fontSize: 10),
                  floatingLabelStyle:TextStyle(color: Color.fromARGB(255, 2, 89, 175)),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  prefixIcon: Icon(Icons.money),
              ),
            ),
          )),
          SizedBox(width: 90,height: 40,
            child:
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: ElevatedButton(
            style: ElevatedButton.styleFrom(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // <-- Radius
              ),
              elevation: 0,
                backgroundColor: const Color.fromARGB(255, 36, 120, 177),
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
              child: const Text('посчитать',selectionColor:Color.fromARGB(255, 255, 255, 255),
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 12),),
                onPressed:(){
                  setState(() {
                  currentpriceController.text = widget.coinsFromApi != null ?
                  widget.coinsFromApi!['market_data']['current_price']['usd'].toString() : coinBlank['currentprice'];
                  quanityController.text = (double.parse(summController.text) / double.parse(currentpriceController.text)).toString();
                  });
            })))]),
          Row(children: [
          const Padding ( padding: EdgeInsets.only(left:10, bottom:0, right: 0, top:0),
          child: Text("Вы покупаете")),
          Padding ( padding: const EdgeInsets.only(left:5, bottom:0, right: 0, top:0),
          child:
          widget.coinsFromApi != null ? Image.network(widget.coinsFromApi?['image']['small'],height: 60) : Image.network(coinBlank['icon'],height: 60)
          ),
          Padding ( padding: const EdgeInsets.only(left:5, bottom:0, right: 0, top:0),
          child:
          widget.coinsFromApi != null ? Text('${widget.coinsFromApi?['name']}') : const Text('TempoCoin')),
          Padding ( padding: const EdgeInsets.only(left:10, bottom:0, right: 0, top:0),
          child:
          widget.coinsFromApi != null ? Text('на сумму ${summController.text} \$ ?') : const Text('TempoCoin')),
          ],),
          SizedBox(width: 360,height: 30,
            child: 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // <-- Radius
          ),
          elevation: 0,
            backgroundColor: const Color.fromARGB(255, 36, 120, 177),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            ),
            child: const Text('СОХРАНИТЬ НОВЫЙ АКТИВ',
            selectionColor:Color.fromARGB(255, 255, 255, 255),style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
            onPressed:(){ updateCoinList(coinForApiPut,context,userName,userJwt);}),
              ))
        ],),
);
    
}
}


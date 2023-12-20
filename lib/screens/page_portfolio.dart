import 'package:flutter/material.dart';
import '../api/Portfolio/portfolio_api.dart';
import '../api/Portfolio/deleteCoin_api.dart';
import '../api/Portfolio/fetchCurrentPrice_api.dart';
import '../models/singlton.dart';

import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

List _initialDataMock = [{'id': 'fPNpsrs3PKTDnZtGGBk0B',
'coin': 'Ethereum', 'price': '0', 'quanity':' 0',
'summ': '0', 'date': '2023-06-12T14:19:16.952Z', 'idcoin': 'ethereum',
'income': '0', 'currentprice': '0',
'icon':'https://assets.coingecko.com/coins/images/738/small/eos-eos-logo.png?1696501893'}];


class PagePortfolio extends StatefulWidget {
  // final String tokenString;
  // final String userNameString;
  const PagePortfolio({super.key});

  @override
  State<PagePortfolio> createState() => _PagePortfolioState();
}
  class _PagePortfolioState extends State<PagePortfolio> {
  Map _resultOfUpdatePrice={
   "ethereum": {
    "usd": 0.0
  }
};
  List? forDeleteCoinsList = [];
  List? forUpdatePriceList = [];


  void _updateAndDeleteCoin(index,tokenString,forDeleteCoinsList) {
  forDeleteCoinsList.removeAt(index);
  print('Delete $index in new array');
  deleteSomeCoinList(tokenString,forDeleteCoinsList);
  print('End of Magic');
}

  @override
  Widget build(BuildContext context) {
  return  Scaffold(
  floatingActionButton:Align(
    alignment: Alignment(0.09, 1.48),
    child: SizedBox(
        height: 150.0,
        width: 100.0,
        child: 
        FittedBox(
          child: 

          FloatingActionButton(
    backgroundColor: Color.fromARGB(255, 255, 226, 64),
    onPressed: ()=>fetchCurrentPrices(forUpdatePriceList,_resultOfUpdatePrice).then((value) => setState((){_resultOfUpdatePrice = value;})),
    tooltip: 'Modal',
      child:const Column(children: [
        // Icon(Icons.update_sharp,color: Color.fromARGB(255, 247, 196, 180),size: 37,),
          Padding(
            padding: EdgeInsets.only(left:0, bottom: 0, right: 0, top:3),
            child: Text('обновить',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 8),))
      ],) 
    )
    )
    )
  ),
  body: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          alignment: Alignment.center,
            child: FutureBuilder(
                future: fetchCoinsPortfolio(context.read<UserProvider>().userJwt,context.read<UserProvider>().userName),
                initialData: _initialDataMock,
                builder: (BuildContext context, AsyncSnapshot snapshot)
                {
                double numForDashboard = 0;
                if( snapshot.hasError ) { return const SizedBox();}
                else {
                forDeleteCoinsList = snapshot.data;
                forUpdatePriceList = snapshot.data;
                  // fetchCurrentPrices(snapshot.data).then((value) => resultOfUpdatePrice = value);
                  // fetchCurrentPrices(snapshot.data).then((value) => setState((){resultOfUpdatePrice = value;})); // this make too much api requests
                  return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length, // TODO make this a count of income array
                itemBuilder: (BuildContext context, int index) {    
                final item = snapshot.data[index];
                String idCoinFromSnap = snapshot.data[index]["idcoin"];
                double currentPriceResult = 0.0;
                if (_resultOfUpdatePrice[idCoinFromSnap]?['usd'] == null) {}
                 else {
                  currentPriceResult = _resultOfUpdatePrice[idCoinFromSnap]?['usd'];
                }
                double letsCalc(priceState,array) {
                    double result = (priceState
                    * 
                    double.parse(array.data[index]["quanity"])
                    -
                    double.parse(array.data[index]["summ"])
                    ).roundToDouble();
                    numForDashboard= numForDashboard+result;
                    appData.income = numForDashboard;
                    print(numForDashboard);
                    return result;
                }
                double calcResult = letsCalc(currentPriceResult, snapshot);
              return
              Dismissible(
              key: Key(item.toString()),
              onDismissed: (direction) {
               _updateAndDeleteCoin(index,context.read<UserProvider>().userJwt,forDeleteCoinsList);
                // setState(() {});
                ScaffoldMessenger.of(context)
               .showSnackBar(SnackBar(
               content: Text('актив ${item["coin"]} удален из списка',
               style:const TextStyle(color: Color.fromARGB(255, 236, 236, 236))),
               backgroundColor:const Color.fromARGB(255, 1, 62, 102)));
              },
              background: Container(color: const Color.fromARGB(255, 145, 3, 3),
              child: 
              const Padding(
              padding: EdgeInsets.only(right: 0),
              child: 
              Flex(direction: Axis.horizontal,
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
              Icon(Icons.delete_forever_outlined,color: Color.fromARGB(255, 255, 255, 255),size: 30.0,),
              Text('Для удаления актива смахните в любую сторону',style: TextStyle(
              fontSize: 12,
              fontWeight:FontWeight.w300,
              color: Color.fromARGB(255, 255, 255, 255),)),
              Icon(Icons.delete_forever_outlined,color: Color.fromARGB(255, 255, 255, 255),size: 30.0,),
              ],)
              )
              ),
              child: 
              Container(
                  decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 247, 247, 247),
                  borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4)
                  ),
                  boxShadow: [
                  BoxShadow(
                  color: const Color.fromARGB(255, 182, 182, 182).withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
                  ),
                  ],
                  ),
                    height: 70,
                    // color: Color.fromARGB(255, 255, 255, 255),
                    child:
                    Column(
                        mainAxisAlignment:MainAxisAlignment.spaceAround,
                        crossAxisAlignment:CrossAxisAlignment.center,
                        children: [
                      Container(
                        width: 400,
                          color:const Color.fromARGB(255, 235, 234, 234),
                          padding: const EdgeInsets.only(left:0, bottom: 0, right: 0, top:0),
                          child: Text('${snapshot.data[index]["coin"]}',
                          textAlign:TextAlign.center,
                          style:const TextStyle(
                          fontSize: 10,
                          fontWeight:FontWeight.w600,
                          letterSpacing: 3,
                          color:Color.fromARGB(255, 95, 94, 94)))),
                      Row(
                      mainAxisSize :MainAxisSize.max,
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: <Widget>[
                          Expanded(child:
                            Padding ( padding: const EdgeInsets.only(left:0, bottom: 0, right:0, top:0), 
                                  child: Image.network(snapshot.data[index]["icon"],width:36,height:36)),
                          ),
                        Expanded(
                          flex: 0,
                          child:Padding(
                            padding: const EdgeInsets.only(left:0, bottom: 0, right: 0, top:0),
                            child:SizedBox(
                                width: 100,
                                child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  Text("${snapshot.data[index]["summ"]} usd"),
                                  Text(double.parse(snapshot.data[index]["quanity"]).toStringAsFixed(2),
                                  style:const TextStyle(fontSize: 10,color: Color.fromARGB(255, 31, 31, 31)))
                                ],)
                        ))),
                        Expanded(
                            child: currentPriceResult == 0.0 ? const Text('данные устарели') : 
                            Column(crossAxisAlignment:CrossAxisAlignment.start,
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text("${snapshot.data[index]["price"]}",style: const TextStyle(fontSize: 12)),
                            Text("$currentPriceResult",
                            style: currentPriceResult < double.parse(snapshot.data[index]["price"])
                            ?const TextStyle(color: Color.fromARGB(255, 153, 1, 1),fontSize: 14)
                            :const TextStyle(color: Color.fromARGB(255, 26, 153, 1),fontSize: 14) ),
                          ],)
                        ),
                        Expanded(
                          child:Container(
                          
                        child: Text('${calcResult.toString()} \$',
                        textAlign:TextAlign.center,
                        style: calcResult < 0 ? const TextStyle(color: Color.fromARGB(255, 153, 1, 1),fontSize: 14) : const TextStyle(color: Color.fromARGB(255, 26, 153, 1),fontSize: 14) ),
                        ))
                      ],
                    ),
                    ],)
              ),
              );},
              separatorBuilder: (BuildContext context, int index) => const Divider(thickness:2,color: Color.fromARGB(0, 188, 207, 230)),
              );}}
              )
              ),
);}}

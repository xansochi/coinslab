import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../models/coins_model.dart';
import '../../models/singlton.dart';
import '../../models/dashboard_model.dart';


const List mockCoinsList = [
{"id":"fPNpsrs3PKTDnZtGGBk0B","icon": "https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1696501400","coin":"Ethereum","price":"1793.59","quanity":"0.0557","summ":"100","date":"2023-06-12T14:19:16.952Z","idcoin":"ethereum"},
{"id":"Y-QrhN92SV4SOPBsYtxDZ","icon": "https://assets.coingecko.com/coins/images/825/small/bnb-icon2_2x.png?1696501970","coin":"BNB","price":"307.3","quanity":"0.325","summ":"100","date":"2023-06-12T14:21:04.094Z","idcoin":"binancecoin"},
{"id":"Dxq8Xm-6AYy7sk5MAkEEQ","icon": "https://assets.coingecko.com/coins/images/5/small/dogecoin.png?1696501409","coin":"Dogecoin","price":"0.07177","quanity":"278","summ":"20","date":"2023-06-12T14:32:57.881Z","idcoin":"dogecoin"},
{"id":"dMT6IKn-uJaUcuR6WUebH","icon": "https://assets.coingecko.com/coins/images/825/small/bnb-icon2_2x.png?1696501970","coin":"BNB","price":"231.5","quanity":"0.215","summ":"50","date":"2023-06-12T15:54:58.830Z","idcoin":"binancecoin"},
{"id":"ksU1w4ShWwleE4OsV4O_E","icon": "https://assets.coingecko.com/coins/images/738/small/eos-eos-logo.png?1696501893","coin":"EOS","price":"0.576","quanity":"167.359","summ":"100","date":"2023-08-31T17:03:59.346Z","idcoin":"eos"},
{"id":"W6g-GZMZBkoiXy3o5qFvR","icon": "https://assets.coingecko.com/coins/images/5/small/dogecoin.png?1696501409","coin":"Dogecoin","price":"0.06335","quanity":"3157.06","summ":"200","date":"2023-08-31T17:05:43.683Z","idcoin":"dogecoin"},
];

final String coinsJson = jsonEncode(mockCoinsList);

num statusCode = 0;
String transferData = '';

Future<List?> fetchCoinsPortfolio(String tokenData, String userName) async {
  String userNameApiURL = 'https://node-auth-api-two.vercel.app/api/auth/$userName';
  final response = await http.get(
    Uri.parse(userNameApiURL),
    headers: {
      'x-access-token': tokenData,
    },
  );
    print(response.statusCode);
    statusCode = response.statusCode;
 if (response.statusCode == 200) {
    transferData = response.body;
    final responseJson = jsonDecode(response.body);
    Coins list = Coins(responseJson);
    List resultData = list.modifyCoinList();

    DashboardCoins dashlist = DashboardCoins(responseJson);
    List dataForSinglton = dashlist.modifyCoinList();
    appData.summ = dataForSinglton[0]['totalsumm'];

    return resultData;
  }
   if (response.statusCode == 500) {
   final responseJson = await jsonDecode(coinsJson);
    Coins list = Coins(responseJson);
    List resultData = list.modifyCoinList();
    return resultData;
  }
   return null;
 }
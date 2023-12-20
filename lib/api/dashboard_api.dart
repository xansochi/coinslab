import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../models/dashboard_model.dart';

const List mockCoinsList = [
{"id":"fPNpsrs3PKTDnZtGGBk0B","icon": "https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1696501400","coin":"Ethereum","price":"1793.59","quanity":"0.0557","summ":"100","date":"2023-06-12T14:19:16.952Z","idcoin":"ethereum"},
];

final String coinsJson = jsonEncode(mockCoinsList);

num statusCode = 0;
String transferData = '';

Future<List?> fetchCoinsDashboard(String tokenData, String userName) async {
  String userNameApiURL = 'https://node-auth-api-two.vercel.app/api/auth/$userName';
  final response = await http.get(
    Uri.parse(userNameApiURL),
    headers: {
      'x-access-token': tokenData,
    },
  );
    print(response.statusCode);
    print('fetchCoinsDashboard');
    statusCode = response.statusCode;
 if (response.statusCode == 200) {
    transferData = response.body;
    final responseJson = jsonDecode(response.body);
    DashboardCoins list = DashboardCoins(responseJson);
    List resultData = list.modifyCoinList();
    return resultData;
  }
   if (response.statusCode == 500) {
   final responseJson = await jsonDecode(coinsJson);
    DashboardCoins list = DashboardCoins(responseJson);
    List resultData = list.modifyCoinList();
    return resultData;
  }
   return null;
 }
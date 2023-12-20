import 'dart:async';

import 'package:http/http.dart' as http;

String getCoinsFromCoinGeckoURL = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en';


Future fetchCoinsFromCoinGecko() async {
  final response = await http
      .get(Uri.parse(getCoinsFromCoinGeckoURL));
  if (response.statusCode == 200) {
      
     String stringResponse = response.body;
     print('fetchCoinsFromCoinGecko');
     print(stringResponse);

    return stringResponse;
  }
    if (response.statusCode == 429) {
      int intResponse = response.statusCode;

   return intResponse;
  } 
  else {

    throw Exception('Failed to load COINSGECKO');
  }
}
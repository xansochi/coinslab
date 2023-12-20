import 'dart:async';
import 'package:http/http.dart' as http;
import '../constants_api.dart';

Future fetchCoinsFromCoinGecko() async {
  final response = await http
      .get(Uri.parse(ConstantsForApi.getCoinsFromCoinGeckoURL));
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
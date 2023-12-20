import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../constants_api.dart';

Future fetchCurrentPrices(data,resultOfUpdatePrice) async {
    String stringCurrentPriceApi(data) {
    String usdPart = '&vs_currencies=usd';
    String urlStringForUpdatePrice = ConstantsForApi.urlStringForUpdatePrice;
    data.forEach((e)=>urlStringForUpdatePrice = urlStringForUpdatePrice+('${e['idcoin']}%2C'));
    urlStringForUpdatePrice = urlStringForUpdatePrice+usdPart;
    return urlStringForUpdatePrice;
  }
  final response = await http
      .get(Uri.parse(stringCurrentPriceApi(data)));
  if (response.statusCode == 200) {
     Map responseFromApi = jsonDecode(response.body);
     print(responseFromApi);
     print("fetchCurrentPrices");
     resultOfUpdatePrice = responseFromApi;
    return responseFromApi;
  }
    if (response.statusCode == 429) {
      int responseFromApi = response.statusCode;
    print(responseFromApi);
    print("fetchCurrentPrices");
   return responseFromApi;
  } 
  else {
    throw Exception('Failed to load COINSGECKO');
  }
}
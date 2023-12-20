import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants_api.dart';

Future deleteSomeCoinList(String tokenData,newData,String userName) async {
  List testArray = newData;
  String testString = json.encode(
      testArray
        );
  final response = await http.put(
    Uri.parse(ConstantsForApi.UpdateCoinsApiURL+userName),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-access-token': tokenData,
      },
      body: jsonEncode(<String, String>
        {
      "data":testString
        }
    ),
  );
  if (response.statusCode == 200) {
    print('Updated ${response.statusCode}');
    print('deleteSomeCoinList');
    return response.body;
  } else {
    // throw Exception('Failed to update album.');
    print('ERROR ${response.statusCode}');
    print('deleteSomeCoinList');

  }
}
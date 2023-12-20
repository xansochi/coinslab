import 'dart:convert';
import 'package:http/http.dart' as http;

Future deleteSomeCoinList(String tokenData,newData) async {
  List testArray = newData;
  String testString = json.encode(
      testArray
        );
  final response = await http.put(
    Uri.parse('https://node-auth-api-two.vercel.app/api/auth/stefan'),
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
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import '../Portfolio/portfolio_api.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

Future updateCoinList(coinForApiPut,context,userName,userJwt) async {
  // dynamic userJwt = context.read<UserProvider>().userJwt;
  // dynamic userName = context.read<UserProvider>().userName;
  String finalUrlForPutApi = 'https://node-auth-api-two.vercel.app/api/auth/$userName';
  List testArray = jsonDecode(transferData);
  testArray.add(coinForApiPut);
  String testString = json.encode(
      testArray
        );
  final response = await http.put(
    Uri.parse(finalUrlForPutApi),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-access-token': userJwt,
      },
      body: jsonEncode(<String, String>
        {
      "data":testString
        }
    ),
  );
  if (response.statusCode == 200) {
         showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(backgroundColor :const Color.fromARGB(255, 7, 187, 97),message:response.body));
    return response.body;
  } else {
          showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(backgroundColor :const Color.fromARGB(255, 148, 0, 32),message:'Ошибка ${response.statusCode} ${response.body}',maxLines:8,textScaleFactor:0.8,
          ));
          print(response.body);
    // throw Exception('Failed to update album.');
  }
}
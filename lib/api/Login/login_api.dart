import 'dart:core';

import 'package:http/http.dart' as http;

var url = Uri.https('node-auth-api-two.vercel.app', '/api/auth/signin', {'q': '{http}'});
    
Future attemptLogIn(String username, String password) async {
  var res = await http.post(url,
  body: {
    "username": username,
    "password": password
  }
  );
  if(res.statusCode == 200) return res.body;
  if(res.statusCode == 404) return res.body;
  if(res.statusCode == 401) return res.body;
  if(res.statusCode == 400) return res.body;
  if(res.statusCode == 500) return res.body;
  print(res.body);
  return null;
}
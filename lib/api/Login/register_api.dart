import 'package:http/http.dart' as http;

var url = Uri.https('node-auth-api-two.vercel.app', '/api/auth/signup', {'q': '{http}'});
    
Future attemptSignUp(String username, String password,String email) async {
  var res = await http.post(url,
  body: {
    "username": username,
    "email": email,
    "password": password,
    "data": "[]",
    "roles":""
  }
  );
  print(res.body);
  if(res.statusCode == 200) return res;
  if(res.statusCode == 400) return res;
  return null;

}

// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';

import 'dart:convert' show json;
import 'package:flutter_animate/flutter_animate.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../components/Login/login_button.dart';
import '../components/Login/signup_button.dart';
import '../components/Login/login_textfield.dart';
import '../components/Login/password_textfield.dart';
import '../components/Login/register_email_textfield.dart';
import '../components/Login/register_password_textfield.dart';
import '../components/Login/register_username_textfield.dart';
import 'myhome_page.dart';
import '../api/Login/login_api.dart';
import '../api/Login/register_api.dart';

import '../provider/user_provider.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _signinUsernameController = TextEditingController();
  final TextEditingController _signinPasswordController = TextEditingController();
  final TextEditingController _signupPasswordController = TextEditingController();
  final TextEditingController _signupUsernameController = TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();
  bool isLoading = false;
  bool isOnLoginPage = true;
  bool isPasswordHide = true;
  // bool isLoading = false;


    String letsTranslateAnswer(data) {
      String result='default';  
      switch (data) {
        case '{"message":"User Not found."}':
        result = 'Такого пользователя не существует';
        break;
        case '{"accessToken":null,"message":"Invalid Password!"}':
        result = 'Неверный пароль';
        break;
        case '{"message":"User was registered successfully!"}':
        result = 'Поздравляем!Вы успешно прошли регистрацию!';
        break;
        case '{"message":"Failed! Username is already in use!"}':
        result = 'Такой логин уже существует';
        break;
        case '{"message":"Failed! Email is already in use!"}':
        result = 'Такой email уже существует';
        break;
      }
      return result;
    }
  void loginAtTap() async {
    var username = _signinUsernameController.text;
    var password = _signinPasswordController.text;
    setState(() {
      isLoading = true;
    });
    var jwt = await attemptLogIn(username, password);
        if(jwt.length > 100) { // TODO Fix this shit
        var data = json.decode(jwt);
        Provider.of<UserProvider>(context, listen: false).setUserData(data);
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'COINS LAB')),
        );
      setState(() {
      isLoading = false;
    });
      } else {
        print("loginAtTap");
        print(jwt);
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(message:letsTranslateAnswer(jwt),
          ),
          );
          setState(() {
      isLoading = false;
    });
      }
    }

    void registerAtTap() async {
      var username = _signupUsernameController.text;
      var email = _signupEmailController.text;
      var password = _signupPasswordController.text;
      setState(() {
        isLoading = true;
      });
      var signupAnswer = await attemptSignUp(username, password, email);
          if(signupAnswer.statusCode == 200) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(message:letsTranslateAnswer(signupAnswer.body),
            ),
          );
              setState(() {
               isLoading = false;
               isOnLoginPage = true;
            });
        } else {
        showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: letsTranslateAnswer(signupAnswer.body)),
          );
            setState(() {
             isLoading = false;
      });
        }
    }
    onIconTap() {
      setState(() {
        isPasswordHide = !isPasswordHide;
      });
}
String randomForAvatar(int min, int max) {
    return (min + Random().nextInt(max - min)).toString();
  }
  

  @override
  Widget build(BuildContext context) {
    String random = randomForAvatar(1,6);
    print(random);
    return  Stack(
        children: 
        <Widget>
        [
          Image.asset(
            "images/test.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: 
              isOnLoginPage ? [
                const SizedBox(height: 10),
                const Text('COINS LAB',
                style: TextStyle(fontSize: 20,color: Color.fromARGB(172, 240, 198, 224),
                fontWeight: FontWeight.w300,letterSpacing: 6,wordSpacing: 8),),
                const SizedBox(height: 30),
                //logo
                    CircleAvatar(
                      radius: 140,
                      backgroundColor: const Color.fromARGB(48, 255, 255, 255),
                      child: Padding(
                        padding: const EdgeInsets.all(8), // Border radius
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset('images/$random.gif'),
                        )
                      ),
                      ),
                const SizedBox(height: 10),
                const Text(
                  'Привет товарищ! Мы по тебе скучали, заходи',
                  style: TextStyle(
                    color: Color.fromARGB(255, 228, 228, 228),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 25),

                //username
                 LoginTextField(
                  controller: _signinUsernameController,
                  hintText: 'логин',
                  obscureText: false,
                ),

                const SizedBox(height: 15),
                //password
                
                PasswordTextField(
                  controller: _signinPasswordController,
                  hintText: 'пароль',
                  obscureText: isPasswordHide,
                  onIconTap:onIconTap,
                  
                ),
                const SizedBox(height: 15),

                //sign in button
                LoginButton(
                  onTap: () => loginAtTap() ,
                  text: 'ВОЙТИ',
                  isLoading: isLoading,
                  ),
                  const SizedBox(height: 95),
                SignUpButton(
                  onTap: () => setState(() => isOnLoginPage = !isOnLoginPage) ,
                  text: 'РЕГИСТРАЦИЯ'
                  ),
              ] : [                                                                // CONDITION SCREEN RENDER 
                const SizedBox(height: 10),
                const Text('COINS LAB',
                style: TextStyle(fontSize: 20,color: Color.fromARGB(172, 240, 198, 224),
                fontWeight: FontWeight.w300,letterSpacing: 6,wordSpacing: 8),),
                const SizedBox(height: 30),
                //logo
                Animate(
                effects: const [FadeEffect()],
                child:CircleAvatar(
                      radius: 140,
                      backgroundColor: const Color.fromARGB(48, 255, 255, 255),
                      child: Padding(
                        padding: const EdgeInsets.all(8), // Border radius
                          child:ClipRRect(
                          borderRadius: BorderRadius.circular(95.0),
                          child: Image.asset('images/$random.gif'),
                        )
                      ),
                                )),
                const SizedBox(height: 10),
                const Text(
                  'Привет! Регистрируйся и заходи!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 228, 228, 228),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 25),

                //username
                Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child:RegisterUsernameTextField(
                  controller: _signupUsernameController,
                  hintText: 'логин',
                  obscureText: false,
                )),
                const SizedBox(height: 15),
                //email
                 Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child:RegisterEmailTextField(
                  controller: _signupEmailController,
                  hintText: 'email',
                  obscureText: false,
                )),
                const SizedBox(height: 15),
                //password
                Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child:RegisterPasswordTextField(
                  controller: _signupPasswordController,
                  hintText: 'пароль',
                  obscureText: isPasswordHide,
                  onIconTap:onIconTap,
                  
                )),
                const SizedBox(height: 15),

                //sign in button
                LoginButton(
                  onTap: () => registerAtTap() ,
                  text: 'ПРОДОЛЖИТЬ',
                  isLoading: isLoading,
                  ),
                  const SizedBox(height: 25),
                SignUpButton(
                  onTap: () => setState(() => isOnLoginPage = !isOnLoginPage) ,
                  text: 'СТРАНИЦА ВХОДА',
                  ),
              ],
            ),
          ),
        ),
      ),
    )
    ]
    );
  }
}


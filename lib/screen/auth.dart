import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

TextEditingController _login_controller = TextEditingController();
TextEditingController _password_controller = TextEditingController();

class Auth extends StatefulWidget {
  const Auth({super.key, required this.title});
  final String title;

  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  String? login = "";
  String? password = "";

    late SharedPreferences shared;

    Future<void> initShared() async {
      shared = await SharedPreferences.getInstance();
      setState(() {});
    }

  @override
  void initState() {
    _login_controller.addListener(onChange);
    _password_controller.addListener(onChange);
    initShared();
    super.initState();
  }

  void onChange() {
    login = _login_controller.text;
    password = _password_controller.text;
  }

  void savePref(String token) async {
    await shared.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 50,
                child: TextFormField(
                  controller: _login_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле имя пользователя пустое';
                    }
                    if (value.length < 3) {
                      return 'Имя пользователя должно быть не менее 2 символов';
                    }
                    return null;
                  },
                  maxLength: 16,
                  decoration: const InputDecoration(
                    labelText: 'Имя пользователя',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: TextFormField(
                  controller: _password_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле пароль пустое';
                    }
                    if (value.length < 3) {
                      return 'Пароль должен быть не менее 6 символов';
                    }
                    return null;
                  },
                  maxLength: 16,
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final response = await Dio().post(
                      'http://127.0.0.1:8080/token',
                      data:
                          User(email: "", password: password, userName: login!)
                              .toJson(),
                    );

                    if (response.statusCode == 200) {
                      if (response.data != null) {
                        User user = User.fromJson(response.data['data']);

                        if (user.accessToken != null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(response.data['message']),
                          ));

                          savePref(user.accessToken.toString());

                          _login_controller.text = '';
                          _password_controller.text = '';

                          Navigator.pushNamed(
                            context,
                            'menu',
                          );
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(response.data['message']),
                      ));
                    }
                  } on DioError catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.response!.data['message'] +
                          ' (' +
                          e.response!.statusCode.toString() +
                          ')'),
                    ));
                  }
                },
                child: const Text('Войти'),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _login_controller.text = '';
                  _password_controller.text = '';

                  Navigator.pushNamed(
                    context,
                    'reg',
                  );
                },
                child: const Text('Создать аккаунт',
                    style: TextStyle(decoration: TextDecoration.underline)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_api/model/user.dart';
import 'package:front_api/screen/finance_list.dart';
import 'package:front_api/screen/profile.dart';

TextEditingController _login_controller = TextEditingController();
TextEditingController _password_controller = TextEditingController();
TextEditingController _email_controller = TextEditingController();

class Reg extends StatefulWidget {
  const Reg({super.key, required this.title});
  final String title;

  @override
  State<Reg> createState() => RegState();
}

class RegState extends State<Reg> {
  String? login = "";
  String? password = "";
  String? email = "";
  Future<void> signIn(String email, String password, String userName) async {
    setState(() {});
  }

  void onChange() {
    login = _login_controller.text;
    password = _password_controller.text;
    email = _email_controller.text;
  }

  @override
  void initState() {
    _login_controller.addListener(onChange);
    _password_controller.addListener(onChange);
    _email_controller.addListener(onChange);
    super.initState();
  }

  Future<void> reg() async {
    try {
      final response = await Dio().put('http://127.0.0.1:8080/token',
          data: User(email: email!, password: password, userName: login!)
              .toJson());

      if (response.statusCode == 200) {
        if (response.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response.data['message']),
          ));

          _login_controller.text = '';
          _password_controller.text = '';
          _email_controller.text = '';

          Navigator.pushNamed(
            context,
            'auth',
          );
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
              SizedBox(
                width: 200,
                height: 50,
                child: TextFormField(
                  controller: _email_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле почта пустое';
                    }
                    return null;
                  },
                  maxLength: 32,
                  decoration: const InputDecoration(
                    labelText: 'Почта',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  reg();
                },
                child: const Text('Зарегистрироваться'),
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
                    'auth',
                  );
                },
                child: const Text('Уже есть аккаунт?',
                    style: TextStyle(decoration: TextDecoration.underline)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

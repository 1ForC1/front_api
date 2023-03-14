import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_api/screen/finance_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

TextEditingController _login_controller = TextEditingController();
TextEditingController _password_controller = TextEditingController();
TextEditingController _email_controller = TextEditingController();

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key, required this.title});
  final String title;

  @override
  State<UpdateProfile> createState() => ProfileState();
}

class ProfileState extends State<UpdateProfile> {
  String? login = "";
  String? password = "";
  String? email = "";

  @override
  void initState() {
    _login_controller.addListener(onChange);
    _password_controller.addListener(onChange);
    _email_controller.addListener(onChange);
    super.initState();
  }

  void onChange() {
    login = _login_controller.text;
    password = _password_controller.text;
    email = _email_controller.text;
  }

  Future<void> updateProfile() async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = shared.getString('token');

      final response = await Dio().post(
        'http://127.0.0.1:8080/user',
        data:
            User(email: email!, password: password, userName: login!).toJson(),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

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
            'menu',
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
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushNamed(
              context,
              'menu',
            );
          },
        ),
        title: const Text("Редактирование профиля"),
        centerTitle: true,
      ),
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
                onPressed: () async {
                  updateProfile();
                },
                child: const Text('Изменить'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

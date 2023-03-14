import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_api/screen/finance_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.title});
  final String title;

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  String email = '';
  String userName = '';

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  Future<void> getProfile() async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = shared.getString('token');

      final response = await Dio().get(
        'http://127.0.0.1:8080/user',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        if (response.data != null) {
          User user = User.fromJson(response.data['data']);

          email = user.email;
          userName = user.userName;

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response.data['message']),
          ));
          setState(() {});
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
              'auth',
            );
          },
        ),
        title: const Text("Профиль"),
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
              Text("Почта: $email"),
              const SizedBox(
                height: 20,
              ),
              Text("Имя пользователя: $userName"),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'update_profile',
                  );
                },
                child: const Text('Редактирование профиля'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_api/model/user.dart';
import 'package:front_api/screen/auth.dart';
import 'package:front_api/screen/create_finance.dart';
import 'package:front_api/screen/finance_list.dart';
import 'package:front_api/screen/menu.dart';
import 'package:front_api/screen/profile.dart';
import 'package:front_api/screen/reg.dart';
import 'package:front_api/screen/update_finance.dart';
import 'package:front_api/screen/update_profile.dart';

const primaryColor = Color.fromARGB(255, 110, 1, 138);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'auth': (context) => const Auth(
              title: 'Авторизация',
            ),
        'reg': (context) => const Reg(
              title: 'Регистрация',
            ),
        'finance_list': (context) => const FinanceList(
              title: 'Список финансов',
            ),
        'profile': (context) => const Profile(
              title: 'Профиль',
            ),
        'menu': (context) => const Menu(
              title: 'Меню',
            ),
        'update_profile': (context) => const UpdateProfile(
              title: 'Редактирование профиля',
            ),
        'create_finance': (context) => const CreateFinance(
              title: 'Добавление финансов',
            ),
        'update_finance': (context) => const UpdateFinance(
              title: 'Изменение финансов',
            )
      },
      title: 'Финансы',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          scaffoldBackgroundColor: Color(0xffffecb3)),
      debugShowCheckedModeBanner: false,
      home: const Auth(title: 'Авторизация'),
    );
  }
}

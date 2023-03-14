import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_api/screen/finance_list.dart';
import 'package:front_api/screen/profile.dart';

import '../model/user.dart';

class Menu extends StatefulWidget {
  const Menu({super.key, required this.title});
  final String title;

  @override
  State<Menu> createState() => MenuState();
}

class MenuState extends State<Menu> {
  final listPage = [
    const FinanceList(
      title: 'Список финансов',
    ),
    const Profile(
      title: 'Профиль',
    ),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffffb300),
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Список финансов',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
      body: listPage[currentIndex],
    );
  }
}
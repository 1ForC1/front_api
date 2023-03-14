import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_api/screen/finance_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/finance.dart';

TextEditingController _operationNumber_controller = TextEditingController();
TextEditingController _name_controller = TextEditingController();
TextEditingController _description_controller = TextEditingController();
TextEditingController _category_controller = TextEditingController();
TextEditingController _sum_controller = TextEditingController();

class UpdateFinance extends StatefulWidget {
  const UpdateFinance({super.key, required this.title});
  final String title;

  @override
  State<UpdateFinance> createState() => UpdateFinanceState();
}

class UpdateFinanceState extends State<UpdateFinance> {
  String? operationNumber = "";
  String? name = "";
  String? description = "";
  String? category = "";
  DateTime selectedDate = DateTime.now();
  String? sum = "";

  @override
  void initState() {
    _operationNumber_controller.addListener(onChange);
    _name_controller.addListener(onChange);
    _description_controller.addListener(onChange);
    _category_controller.addListener(onChange);
    _sum_controller.addListener(onChange);
    super.initState();
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void onChange() {
    operationNumber = _operationNumber_controller.text;
    name = _name_controller.text;
    description = _description_controller.text;
    category = _category_controller.text;
    sum = _sum_controller.text;
  }

  Future<void> createFinance() async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = shared.getString('token');
      String? id = shared.getString('id');

      final response = await Dio().put(
        'http://127.0.0.1:8080/finance/${id}',
        data: Finance(
          operationNumber: operationNumber,
          name: name,
          description: description,
          category: category,
          date: selectedDate.toString(),
          sum: double.parse(sum!),
        ).toJson(),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        if (response.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response.data['message']),
          ));

          _operationNumber_controller.text = '';
          _name_controller.text = '';
          _description_controller.text = '';

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
        title: const Text("Изменение финанса"),
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
                  controller: _operationNumber_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле номер операции пустое';
                    }
                    return null;
                  },
                  maxLength: 16,
                  decoration: const InputDecoration(
                    labelText: 'Номер операции',
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
                  controller: _name_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле название пустое';
                    }
                    return null;
                  },
                  maxLength: 32,
                  decoration: const InputDecoration(
                    labelText: 'Название',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: TextFormField(
                  maxLines: null,
                  controller: _description_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле описание пустое';
                    }
                    return null;
                  },
                  maxLength: 100,
                  decoration: const InputDecoration(
                    labelText: 'Описание',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: TextFormField(
                  controller: _category_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле категория пустое';
                    }
                    return null;
                  },
                  maxLength: 100,
                  decoration: const InputDecoration(
                    labelText: 'Категория',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text(
                      'Выбрать дату',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: TextFormField(
                  controller: _sum_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле суммы пустое';
                    }
                    return null;
                  },
                  maxLength: 100,
                  decoration: const InputDecoration(
                    labelText: 'Сумма',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  createFinance();
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

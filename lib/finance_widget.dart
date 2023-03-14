import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinanceWidget extends StatelessWidget {
  final String? id;
  final String? operationNumber;
  final String? name;
  final String? description;
  final String? category;
  final String? date;
  final String? sum;
  final BuildContext? contextWidget;

  FinanceWidget(
      {Key? key,
      required this.id,
      required this.operationNumber,
      required this.name,
      required this.description,
      required this.category,
      required this.date,
      required this.sum,
      required this.contextWidget})
      : super(key: key);

  Future<void> delete(BuildContext context) async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = shared.getString('token');

      final response = await Dio().delete(
        'http://127.0.0.1:8080/finance/${id.toString()}',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        if (response.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response.data['message']),
          ));
          Navigator.pushNamed(
            contextWidget!,
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

  Future<void> deleteLogical(BuildContext context) async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = shared.getString('token');

      final response = await Dio().delete(
        'http://127.0.0.1:8080/logical/${id.toString()}',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        if (response.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response.data['message']),
          ));
          Navigator.pushNamed(
            contextWidget!,
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
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 175,
          width: 250,
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(188, 253, 90, 31),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  description!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  date!,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences shared =
                            await SharedPreferences.getInstance();
                        await shared.setString('id', id!);

                        Navigator.pushNamed(
                          context,
                          'update_finance',
                        );
                      },
                      child: const Text('Изменить'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        delete(context);
                      },
                      child: const Text('Удалить'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    deleteLogical(context);
                  },
                  child: const Text('Скрыть'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

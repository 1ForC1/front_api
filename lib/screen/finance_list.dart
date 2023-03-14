import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_api/finance_widget.dart';
import 'package:front_api/screen/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/finance.dart';
import '../model/user.dart';

class FinanceList extends StatefulWidget {
  const FinanceList({super.key, required this.title});
  final String title;

  @override
  State<FinanceList> createState() => FinanceListState();
}

class FinanceListState extends State<FinanceList> {
  var listFinance;

  @override
  void initState() {
    listFinance = getFinanceList();
    super.initState();
  }

  Future<List<Finance>> getFinanceList() async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = shared.getString('token');

      final response = await Dio().get(
        'http://127.0.0.1:8080/finance?page=1',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        if (response.data != null) {
          var financesData = response.data as List;
          return financesData.map((i) => Finance.fromJson(i)).toList();
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
    throw Exception('Failed to load petitions');
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
        title: const Text("Финансы"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'create_finance');
        },
        child: const Icon(Icons.add),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Finance>>(
            future: listFinance,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if ((snapshot.data as List<Finance>).isNotEmpty) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 600,
                        width: 500,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                var finance =
                                    (snapshot.data as List<Finance>)[index];
                                return FinanceWidget(
                                  id: finance.id.toString(),
                                  operationNumber: finance.operationNumber,
                                  name: finance.name,
                                  description: finance.description,
                                  category: finance.category,
                                  date: finance.date,
                                  sum: finance.sum.toString(),
                                  contextWidget: context,
                                );
                              },
                              itemCount:
                                  (snapshot.data as List<Finance>).length),
                        ),
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      Text('Здесь пусто...')
                    ],
                  );
                }
              } else {
                return const CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(188, 253, 90, 31),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = <String>[];
  List<Finance> list = <Finance>[];

  final Dio dio = Dio();

  void getList() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String? token = shared.getString('token');
    final response = await dio.get('http://127.0.0.1:8080/finance?page=1',
        options: Options(headers: {"Authorization": "Bearer $token"}));
    while (true) {
      try {
        Finance finances = Finance(
            id: response.data[list.length]['id'],
            operationNumber: response.data[list.length]['operationNumber'],
            name: response.data[list.length]['name'],
            description: response.data[list.length]['description'],
            category: response.data[list.length]['category'],
            date: response.data[list.length]['date'],
            sum: response.data[list.length]['sum']);

        searchTerms.add(finances.name!);
        list.add(finances);
      } catch (exception) {
        print(exception);
        break;
      }
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    getList();
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getList();
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

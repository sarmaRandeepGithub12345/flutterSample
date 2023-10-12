import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:project/functions/currency_api.dart';
import 'package:project/functions/utils.dart';

import 'package:project/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  Map<String, dynamic> test = {};

  var _selectedItemOne = "USD";
  var _selectedItemTwo = "USD";
  List<String> currency = [];
  TextEditingController val1 = new TextEditingController();
  var val2 = "";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 237, 124, 3),
          toolbarHeight: 70,
          title: Text(
            'Currency Converter',
            style: TextStyle(
              color: Colors.purple,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: new Color(0xfffcbe03)),
            child: Padding(
              padding: EdgeInsets.all(23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await fetchData();
                    },
                    child: Text(
                      'Search Options',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          color: Colors.white,
                          child: DropdownButton<String>(
                            value: _selectedItemOne,
                            items: currency.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                  '$item',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: '$item',
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedItemOne = value!;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(23),
                          child: Text(
                            'To',
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          width: 150,
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: DropdownButton<String>(
                            value: _selectedItemTwo,
                            items: currency.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                  '$item',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: '$item',
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedItemTwo = value!;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          color: Colors.white,
                          child: TextField(
                            controller: val1,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,3}')),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(23),
                          child: ElevatedButton(
                            onPressed: () {
                              var curOnewrtD = test["$_selectedItemOne"];
                              var curTwowrtD = test["$_selectedItemTwo"];
                              var tmp =
                                  (curTwowrtD * findNum(val1)) / curOnewrtD;

                              val2 = "$tmp";
                              setState(() {});
                            },
                            child: Text(
                              'Find',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          width: 150,
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            '$val2',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                  // Container(
                  //   height: 100,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //   ),
                  // )
                ],
              ),
            )));
  }

  Future<void> fetchData() async {
    late final response;
    if (currency.length > 0) {
      return;
    }
    response = await CurrencyApi.fetchRates();

    final rates = response.rates as Map<String, dynamic>;
    test = rates;
    rates.forEach((key, value) {
      currency.add(key);
    });

    setState(() {});
  }
}

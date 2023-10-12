import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  final String title;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MyHomePage(title: '');
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: new Color(0xfffcbe03),
        child: Center(
          child: SvgPicture.asset(
            "assets/images/dollar.svg",
            semanticsLabel: "Done",
            width: 500,
            height: 500,
          ),
        ),
      ),
    );
  }
}

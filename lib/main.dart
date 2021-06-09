import 'package:flutter/material.dart';
import 'package:sweetgiftbox/view/loginscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Sweet GiftBox', home: LoginScreen());
  }
}


import 'package:bytebank/screens/counter_page.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'components/theme.dart';



void main() {
  runApp(ByteBank());
}

class ByteBank extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: bytebankTheme,
      home: CounterContainer()
    );
  }
}




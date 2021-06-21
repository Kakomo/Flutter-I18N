import 'package:bytebank/components/localization.dart';
import 'package:bytebank/screens/counter_page.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/language_screen.dart';
import 'package:bytebank/screens/name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'components/theme.dart';



void main() {
  runApp(ByteBank());
}

class LogObserver extends BlocObserver{
  @override
  void onChange(Cubit cubit, Change change) {
    print("${cubit.runtimeType}> $change");
    super.onChange(cubit, change);
  }
}

class ByteBank extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bloc.observer = LogObserver();
    return MaterialApp(
      theme: bytebankTheme,
      home: LanguageScreen()

    );
  }
}




import 'package:flutter/material.dart';
import 'package:flutter_estados/models/saldo.dart';
import 'package:flutter_estados/screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

import 'models/transferencias.dart';

void main() =>
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Saldo(0),
        ),
        ChangeNotifierProvider(
         create: (context) => Transferencias(),
        ),
      ],
      child: BytebankApp(),
    ));

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    );
  }
}

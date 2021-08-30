import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_estados/models/saldo.dart';
import 'package:flutter_estados/screens/dashboard/saldo.dart';

class Dashboard extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SaldoCard(Saldo(10.00)
        ),
      ),
    );
  }
}
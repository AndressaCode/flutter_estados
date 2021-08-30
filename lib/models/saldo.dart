import 'package:flutter/cupertino.dart';
import 'package:flutter_estados/screens/dashboard/saldo.dart';

class Saldo extends ChangeNotifier{
  final double valor;

  Saldo(this.valor);

  @override
  String toString(){
    return 'R\$ $valor';
  }
}
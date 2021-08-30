import 'package:flutter_estados/screens/dashboard/saldo.dart';

class Saldo {
  final double valor;

  Saldo(this.valor);

  @override
  String toString(){
    return 'R\$$valor';
  }
}
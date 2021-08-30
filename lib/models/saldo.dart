import 'package:flutter/cupertino.dart';
import 'package:flutter_estados/screens/dashboard/saldo.dart';

class Saldo extends ChangeNotifier{
  double valor;
  Saldo(this.valor);

  void adiciona(double valor){
    this.valor += valor;
    notifyListeners();
  }
  void subtrai(double valor){
    this.valor -=valor;
    notifyListeners();
  }

  @override
  String toString(){
    return 'R\$ $valor';
  }
}
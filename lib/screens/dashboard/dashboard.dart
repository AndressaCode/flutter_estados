import 'package:flutter/material.dart';
import 'package:flutter_estados/models/saldo.dart';
import 'package:flutter_estados/screens/dashboard/saldo.dart';
import 'package:flutter_estados/screens/deposito/formulario.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Receber depósito'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormularioDeposito();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_estados/models/saldo.dart';
import 'package:flutter_estados/screens/dashboard/saldo.dart';
import 'package:flutter_estados/screens/deposito/formulario.dart';
import 'package:flutter_estados/screens/transferencia/formulario.dart';
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
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text('Receber depósito'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormularioDeposito();
                  }));
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text('Nova transferência'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormularioTransferencia();
                  }));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

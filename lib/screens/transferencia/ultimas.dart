import 'package:flutter/material.dart';
import 'package:flutter_estados/models/transferencias.dart';
import 'package:provider/provider.dart';

import 'lista.dart';

class UltimasTransferencias extends StatelessWidget {
  final _titulo = 'Ultimas transferências';

  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Consumer<Transferencias>(
          builder: (context, transferencias, child) {
            return ListView.builder(
                padding: EdgeInsets.all(8.0),
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, indice) {
                  return ItemTransferencia(transferencias.transferencias[indice]);
              }
            );
          }
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          child: Text('Transferências'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ListaTransferencias();
            }));
          },
        ),
      ],
    );
  }
}

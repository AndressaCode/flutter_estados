import 'package:flutter/material.dart';
import 'package:flutter_estados/models/cliente.dart';
import 'package:flutter_estados/models/saldo.dart';
import 'package:flutter_estados/screens/autenticacao/login.dart';
import 'package:flutter_estados/screens/dashboard/saldo.dart';
import 'package:flutter_estados/screens/deposito/formulario.dart';
import 'package:flutter_estados/screens/transferencia/formulario.dart';
import 'package:flutter_estados/screens/transferencia/lista.dart';
import 'package:flutter_estados/screens/transferencia/ultimas.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
      ),

      // Estava retornando um ListView.. por quê?
      body: SingleChildScrollView(
        child: Column(
          children: [

            Consumer<Cliente>(
              builder: (context, cliente, child) {

                if(cliente.nome != null){
                  return Text(
                    'Olá, ${cliente.nome.split(" ")[0]} o seu saldo de hoje é: ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }

                return Text(
                  'Olá, o seu saldo de hoje é: ',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            ),

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
            UltimasTransferencias(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text('Sair'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_estados/models/cliente.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Biometria extends StatelessWidget {
  final LocalAuthentication _autenticacaoLocal = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _biometriaDisponivel(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Column(
                children: [
                  Text('Seu smartphone tem sensor biométrico. '
                      'Deseja cadastrar a biometria agora?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      await _autenticarCliente(context);
                    } ,
                    child: Text('Habilitar impressão digital'),
                  ),
                ],

              ),
            );
          }

          return Container();
        }

    );
  }

  Future<bool> _biometriaDisponivel() async {
    try {
      return await _autenticacaoLocal.canCheckBiometrics;
    } on PlatformException catch (erro) {
      print(erro);
    }
  }

  Future<void> _autenticarCliente(context) async {
    bool autenticado = false;
    autenticado = await _autenticacaoLocal.authenticate(
      localizedReason:
      'Por favor, autentique-se via biometria para acessar o Bytebank',
      biometricOnly: true,
      useErrorDialogs: true,
    );

    Provider
        .of<Cliente>(context, listen: false)
        .biometria = autenticado;
  }
}

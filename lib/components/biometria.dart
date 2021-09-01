import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_estados/models/cliente.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Biometria extends StatelessWidget {
  final LocalAuthentication _autenticacaoLocal = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Container();
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

    Provider.of<Cliente>(context, listen: false).biometria = autenticado;
  }
}
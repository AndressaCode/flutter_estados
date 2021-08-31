import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_estados/components/mensagem.dart';
import 'package:flutter_estados/screens/autenticacao/registrar.dart';
import 'package:flutter_estados/screens/dashboard/dashboard.dart';

class Login extends StatelessWidget {
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/bytebank_logo.png',
                  width: 200,
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300.0,
                  height: 455.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _construirFormulario(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirFormulario(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Faça seu login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'CPF',
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            validator: (value) {
              if (value.length == 0) return "Informe o CPF";

              if (value.length < 14) return "CPF inválido!";

              return null;
            },
            keyboardType: TextInputType.number,
            maxLength: 14,
            controller: _cpfController,
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
            validator: (value) {
              if (value.length == 0) {
                return 'Informe sua senha!';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            maxLength: 15,
            controller: _senhaController,
          ),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              child: Text(
                'CONTINUAR',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                side: BorderSide(
                  width: 2,
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (_cpfController.text == '111.111.111-11' &&
                      _senhaController.text == 'abc123') {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ),
                        (route) => false);
                  } else {
                    return exibirAlerta(
                      context: context,
                      titulo: 'ATENÇÃO',
                      content: 'CPF ou senha incorretos!',
                    );
                  }
                }
              },
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Esqueci minha senha >',
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          SizedBox(height: 24),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              side: BorderSide(
                width: 2,
                color: Color.fromRGBO(71, 161, 56, 0.2),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Registrar(),
                ),
              );
            },
            child: Text(
              'Criar uma conta',
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

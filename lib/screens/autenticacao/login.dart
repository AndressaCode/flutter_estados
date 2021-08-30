import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_estados/screens/dashboard/dashboard.dart';

class Login extends StatelessWidget {
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .accentColor,
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
              SizedBox(
                height: 30,
              ),
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
                    child: Column(
                      children: [
                        Text(
                          'Faça seu login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 16.0),

                        TextField(
                          decoration: InputDecoration(
                            labelText: 'CPF',
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          controller: _cpfController,
                        ),

                        SizedBox(height: 20.0),

                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Senha',
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          controller: _senhaController,
                        ),

                        SizedBox(height: 30),

                        SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                side: BorderSide(
                                  width: 2,
                                  color: Theme
                                      .of(context)
                                      .accentColor,
                                ),
                              ),
                              onPressed: () {
                                if (_validaCampos()) {
                                  Navigator.pushAndRemoveUntil(
                                      context, MaterialPageRoute(
                                    builder: (context) => Dashboard(),
                                  ),
                                          (route) => false
                                  );
                                }
                              },
                              child: Text('CONTINUAR', style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),),
                            ),
                        ),

                        SizedBox(height: 16),

                        Text('Esqueci minha senha >',
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
                            onPressed: () {},
                            child: Text('Criar uma conta',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validaCampos() {
    if (_cpfController.text.length > 0 && _senhaController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }
}

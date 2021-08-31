import 'package:flutter/material.dart';

class Registrar extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de clientes'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Nome',
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Registrar extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();

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
          child: Column(
            children: [
              // Nome
              TextFormField(
                controller: _nomeController,
                keyboardType: TextInputType.text,
                maxLength: 255,
                validator: (value) {
                  if (value.contains(" "))
                    return 'Informe pelo menos um sobrenome!';

                  if (value.length < 3) return 'Nome inválido';

                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              // E-mail
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                maxLength: 255,
                validator: (value) {
                  if (!value.contains("@") || (!value.contains('.')))
                    return 'E-mail inválido!';

                  if (value.length < 3) return 'E-mail muito curto';

                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
              ),

              // CPF
              TextFormField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                maxLength: 14,
                validator: (value) {
                  if (value.length != 14)
                    return 'CPF inválido!';

                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                decoration: InputDecoration(
                  labelText: 'CPF',
                ),
              ),

              // Celular
              TextFormField(
                controller: _celularController,
                keyboardType: TextInputType.number,
                maxLength: 14,
                validator: (value) {
                  if (value.length < 11)
                    return 'Celular inválido!';

                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                decoration: InputDecoration(
                  labelText: 'Celular',
                ),
              ),

              // Nascimento
              DateTimePicker(
                controller: _nascimentoController,
                type: DateTimePickerType.date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Nascimento',
                dateMask: 'dd/MM/yyyy',
                validator: (value) {
                  if(value.isEmpty)
                    return 'Data inválida!';

                  return null;
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
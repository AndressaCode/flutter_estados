import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_estados/screens/dashboard/dashboard.dart';

class Registrar extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _mesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de clientes'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: [
                  // Nome
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                    controller: _nomeController,
                    keyboardType: TextInputType.text,
                    maxLength: 255,
                    validator: (value) {

                      if (value.length < 3) return 'Nome inválido';

                      // Verifica a não existência de espaço entre duas palavras
                      // Significa dizer que só existe uma
                      if (!value.contains(" "))
                        return 'Informe pelo menos um sobrenome!';

                      return null;
                    },
                  ),
                  // E-mail
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 255,
                    validator: (value) {
                      if (!value.contains("@") || (!value.contains('.')))
                        return 'E-mail inválido!';

                      if (value.length < 3) return 'E-mail muito curto';

                      return null;
                    },
                  ),

                  // CPF
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'CPF',
                    ),
                    controller: _cpfController,
                    keyboardType: TextInputType.number,
                    maxLength: 14,
                    validator: (value) {
                      if (value.length != 14) return 'CPF inválido!';

                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),

                  // Celular
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Celular',
                    ),
                    controller: _celularController,
                    keyboardType: TextInputType.number,
                    maxLength: 14,
                    validator: (value) {
                      if (value.length < 11) return 'Celular inválido!';

                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
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
                        if (value.isEmpty) return 'Data inválida!';

                        return null;
                      }),
                  SizedBox(height: 12.0),

                  // Cep
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'CEP',
                    ),
                    controller: _cepController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value.length < 10) return 'CEP inválido!';

                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                  ),

                  // Estado
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: 'Estado'),
                    items: Estados.listaEstadosSigla.map((String estado) {
                      return DropdownMenuItem(
                        child: Text(estado),
                        value: estado,
                      );
                    }).toList(),
                    onChanged: (String novoEstadoSelecionado) {
                      _estadoController.text = novoEstadoSelecionado;
                    },
                    validator: (value) {
                      if (value == null) return 'Selecione um estado!';

                      return null;
                    },
                  ),

                  SizedBox(height: 12.0),

                  // Cidade
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Cidade',
                    ),
                    controller: _cidadeController,
                    keyboardType: TextInputType.text,
                    maxLength: 14,
                    validator: (value) {
                      if (value.length < 3) return 'Cidade inválida!';

                      return null;
                    },
                  ),

                  // Bairro
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Bairro',
                    ),
                    controller: _bairroController,
                    keyboardType: TextInputType.text,
                    maxLength: 14,
                    validator: (value) {
                      if (value.length < 3) return 'Bairro inválido!';

                      return null;
                    },
                  ),

                  // Logradouro
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Logradouro',
                    ),
                    controller: _logradouroController,
                    keyboardType: TextInputType.text,
                    maxLength: 14,
                    validator: (value) {
                      if (value.length < 3) return 'Logradouro inválido!';

                      return null;
                    },
                  ),

                  // Numero
                  // Não tem número específico para usar uma mask,
                  // uma vez que ele pode ser um ap, casa sem número,
                  // entre outros
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Número',
                    ),
                    controller: _celularController,
                    keyboardType: TextInputType.text,
                    maxLength: 255,
                  ),

                  // Estado
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: 'Mês'),
                    items: Meses.listaMeses.map((String mes) {
                      return DropdownMenuItem(
                        child: Text(mes),
                        value: mes,
                      );
                    }).toList(),
                    onChanged: (String novoMesSelecionado) {
                      _mesController.text = novoMesSelecionado;
                    },
                    validator: (value) {
                      if (value == null) return 'Selecione um mês!';

                      return null;
                    },
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
                      if (_formKey.currentState.validate()) {
                        // Retira o histórico, o botão de voltar na appBar
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(),
                          ),
                          // estamos passando um widget ao invés de uma rota nomeada
                              (route) => false,
                        );
                      }
                    },

                    // Finalizar cadastro
                    child: Text(
                      'Finalizar cadastro',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

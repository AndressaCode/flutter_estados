import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_estados/models/cliente.dart';
import 'package:flutter_estados/screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:image_picker/image_picker.dart';

class Registrar extends StatelessWidget {
  // step 1
  final _formUserData = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();

  // step 2
  final _formUserAddress = GlobalKey<FormState>();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  // step 3
  final _formUserAuth = GlobalKey<FormState>();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmarSenhaController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de clientes'),
      ),
      body: Consumer<Cliente>(builder: (context, cliente, child) {
        return Stepper(
            currentStep: cliente.stepAtual,
            onStepContinue: () {
              final functions = [
                _salvarStep1,
                _salvarStep2,
                _salvarStep3,
              ];
              return functions[cliente.stepAtual](context);
            },
            onStepCancel: () {
              cliente.stepAtual =
                  cliente.stepAtual > 0 ? cliente.stepAtual - 1 : 0;
            },
            steps: _construirSteps(context, cliente),
            controlsBuilder: (context, {onStepContinue, onStepCancel}) {
              return Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).accentColor)),
                      onPressed: onStepContinue,
                      child: Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 18.0),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: onStepCancel,
                      child: Text(
                        'Voltar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }

  _salvarStep1(context) {
    if (_formUserData.currentState.validate()) {
      // Criamos uma variável com acesso ao model de cliente
      Cliente cliente = Provider.of<Cliente>(context, listen: false);
      cliente.nome = _nomeController.text;

      _proximoStep(context);
    }
  }

  _salvarStep2(context) {
    if (_formUserAddress.currentState.validate()) {
      _proximoStep(context);
    }
  }

  _salvarStep3(context) {
    if (_formUserAuth.currentState.validate() && Provider.of<Cliente>(context).imagemRG != null) {
      FocusScope.of(context).unfocus();
      Provider.of<Cliente>(context).imagemRG = null;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        (route) => false,
      );
    }
  }

  _construirSteps(context, cliente) {
    List<Step> step = [
      // Dados do cliente
      Step(
        title: Text('Seus dados'),
        isActive: cliente.stepAtual >= 0,
        content: Form(
          key: _formUserData,
          child: Column(
            children: [
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
                validator: (value) =>
                    Validator.email(value) ? 'E-mail Inválido!' : null,
              ),

              // CPF
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'CPF',
                ),
                controller: _cpfController,
                keyboardType: TextInputType.number,
                maxLength: 14,
                validator: (value) =>
                    Validator.cpf(value) ? 'CPF Inválido!' : null,
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
                maxLength: 15,
                validator: (value) =>
                    Validator.phone(value) ? 'Celular Inválido!' : null,
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
            ],
          ),
        ),
      ),

      // Endereço
      Step(
        title: Text('Endereço'),
        isActive: cliente.stepAtual >= 1,
        content: Form(
          key: _formUserAddress,
          child: Column(
            children: [
              // CEP
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: 'CEP',
              //   ),
              //   controller: _cepController,
              //   keyboardType: TextInputType.number,
              //   maxLength: 10,
              //   // validator: (value) =>
              //   //     Validator.cep(value) ? 'CEP Inválido!' : null,
              //   inputFormatters: [
              //     FilteringTextInputFormatter.digitsOnly,
              //     CepInputFormatter(),
              //   ],
              // ),

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
                controller: _numeroController,
                keyboardType: TextInputType.text,
                maxLength: 255,
              ),
            ],
          ),
        ),
      ),

      // Autenticação
      Step(
        title: Text('Autenticação'),
        isActive: cliente.stepAtual >= 2,
        content: Form(
          key: _formUserAuth,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                controller: _senhaController,
                keyboardType: TextInputType.text,
                maxLength: 255,
                obscureText: true,
                validator: (value) {
                  if (value.length < 8) return 'Senha muito curta!';

                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
              ),

              // Confirmar senha
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirmar',
                ),
                controller: _confirmarSenhaController,
                keyboardType: TextInputType.text,
                maxLength: 255,
                obscureText: true,
                validator: (value) {
                  if (value != _senhaController.text)
                    return 'Campo diferente da senha informada!!';

                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
              ),

              SizedBox(height: 16.0),

              Text(
                'Para prosseguir com o cadastro é necesário que tenha a foto do seu RG',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () => _capturarRG(cliente),
                child: Text('Tirar foto do meu RG'),
              ),

              _jaEnviouRG(context) ? _imagemDoRG(context) : _pedidoDeRG(context),
            ],
          ),
        ),
      ),
    ];
    return step;
  }

  void _proximoStep(context) {
    Cliente cliente = Provider.of<Cliente>(context, listen: false);
    irPara(cliente.stepAtual + 1, cliente);
  }

  void irPara(int step, cliente) {
    cliente.stepAtual = step;
  }

  // A câmera é assincrona, por isso devemos utilizar o await.
  // Para o await funcionar usamos o async

  void _capturarRG(cliente) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    cliente.imagemRG = File(pickedImage.path);
  }

  bool _jaEnviouRG(context) {
    if (Provider.of<Cliente>(context).imagemRG != null) return true;

    return false;
  }

  Image _imagemDoRG(context) {
    return Image.file(Provider.of<Cliente>(context).imagemRG);
  }

  Column _pedidoDeRG(context) {
    return Column(
      children: [
        SizedBox(height: 16.0),
        Text(
          'Foto do RG pendente!',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}

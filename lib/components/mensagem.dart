import 'package:flutter/material.dart';


exibirAlerta({context, titulo, content}){
// context = De onde está chamando a função
showDialog(
  context: context,
  builder: (BuildContext context){
    return AlertDialog(
      title: Text(titulo,),
      content: Text(content),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Fechar'),
        )
      ],
    );
  },
);
}
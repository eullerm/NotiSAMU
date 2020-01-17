import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Registro/perguntasErroDePrescri%C3%A7%C3%A3o.dart';
import 'package:noti_samu/screens/notificacao.dart';

class Categoria extends StatefulWidget {
  Notificacao notificacao;
  Categoria(this.notificacao);
  @override
  _CategoriaState createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {

  Map<String, bool> _categorias = {
    'Erro de Prescrição': false,
    'Erro de Dispensação': false,
    'Erro de Preparo': false,
    'Erro de Administração': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Registro de dados da ocorrência"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        _categoriaIncidente(),
      ],
    );
  }

  _categoriaIncidente() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Categoria de incidente:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        _checkBoxButton(),
      ],
    );
  }

  _checkBoxButton() {
    return Column(
      children: _categorias.keys
          .map(
            (String key) => CheckboxListTile(
              title: Text(key),
              value: _categorias[key],
              onChanged: (bool value) {
                setState(() {
                  _categorias[key] = value;
                });
              },
            ),
          )
          .toList(),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        _categorias.forEach((k, v) {
           if(v == true) this.widget.notificacao.incidente.add(k);
           });
        print(widget.notificacao.notificante);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Perguntas(widget.notificacao)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Registro/perguntasDaCategoria.dart';

class Categoria extends StatefulWidget {
  @override
  _CategoriaState createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
  Map<String, bool> _categorias = {
    'X': false,
    'Y': false,
    'Z': false,
    'S': false,
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
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Perguntas()));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}

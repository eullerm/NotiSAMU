import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Relator/Registro/registroRelatorOpcional.dart';

class Aviso extends StatefulWidget {
  @override
  _AvisoState createState() => _AvisoState();
}

class _AvisoState extends State<Aviso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Noti SAMU"),
      ),
      body: _body(context),
    );
  }

  _body(context){
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(16),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget> [
          _msg(size),
          _botaoContinuar(size), 
        ],
      ),
    );
  }

  _msg(size){
    return Text(
      ("""A notificação não apresenta caráter punitivo. Ela visa a segurança do paciente e uma melhor qualidade no atendimento ao usuário da unidade de saúde."""),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
      ),
    );
  }

  _botaoContinuar(size){
    return ButtonTheme(
      minWidth: size.width,
      child: RaisedButton(
        color: Colors.grey[350],
        child: Text(
          "Acessar",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        onPressed: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Relator()));
        },
      ),
    );
  }
}
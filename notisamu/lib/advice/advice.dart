import 'package:flutter/material.dart';
import 'package:noti_samu/screens/notifying/record/notifying.dart';
import 'package:noti_samu/services/baseAuth.dart';
import 'package:page_transition/page_transition.dart';

class Advice extends StatefulWidget {
  Advice(this.base, this.auth);

  final BaseAuth auth;
  final String base;

  @override
  _AdviceState createState() => _AdviceState();
}

class _AdviceState extends State<Advice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
        title: Text("NotiSAMU"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            this.widget.auth.signOut();
            Navigator.pop(context);
          },
        ),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("size: " + size.toString());
    return Container(
      padding: EdgeInsets.all(16),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _advice(),
          SizedBox(
            width: size.width,
            child: _button(),
          ),
        ],
      ),
    );
  }

  _advice() {
    return Column(
      children: <Widget>[
        _text(
            "A notificação não apresenta caráter punitivo. " +
                "Notificando um incidente, você colabora para a " +
                "segurança do paciente e a qualidade do atendimento ao usuário do serviço.",
            25.0),
        _text("VOCÊ NÃO SERÁ IDENTIFICADO!", 22.0)
      ],
    );
  }

  _text(String string, double font) {
    return Text(
      (string),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: font,
      ),
    );
  }

  _button() {
    return ButtonTheme(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF002C3E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 200),
                  type: PageTransitionType.rightToLeft,
                  child: Notifying(this.widget.base)));
        },
        child: Text(
          "Acessar",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

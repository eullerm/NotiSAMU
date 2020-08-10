import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noti_samu/components/cardNotify.dart';
import 'package:noti_samu/screens/Admin/detailsNotice.dart';
import 'package:noti_samu/login.dart';
import 'package:noti_samu/services/baseAuth.dart';

class Feed extends StatefulWidget {
  
  Feed(this.base, this.auth);

  final String base;
  final BaseAuth auth;

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Map<String, bool> _filter = {
    "Incidente com dano": false,
    "Incidente sem dano": false,
    "Circunstância notificavel": false,
    "Quase erro": false,
  };

  Map<String, bool> _orderBy = {
    "Data de ocorrencia": false,
    "Data de nascimento": false,
  };

  String _choiceFilter;
  String _choiceIncident;
  bool showCheckboxFilter = false;
  bool showCheckboxOrder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Noti SAMU"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            this.widget.auth.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login(auth: this.widget.auth)));
                

          },
        ),
        actions: <Widget>[
          _orderButton(),
          _filterButton(),
        ],
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    String type =
        showCheckboxFilter ? "Filtro" : (showCheckboxOrder ? "Ordem" : "");
    /*if (showCheckboxFilter)
      type = "Filtro";
    else if (showCheckboxOrder) type = "Ordem";*/

    return Stack(
      children: <Widget>[
        _listIncidents(),
        Positioned(
          top: 0,
          right: 0,
          child: _checkboxAnimated(context, type),
        ),
      ],
    );
  }

  _listIncidents() {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
      child: StreamBuilder(
        stream: _order(_choiceFilter, specif: _choiceIncident),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            default:
              return Center(
                child: ListView(
                  children: _listNotify(snapshot),
                ),
              );
          }
        },
      ),
    );
  }

  _filterButton() {
    return IconButton(
      icon: Icon(Icons.filter_list),
      tooltip: "Filtrar",
      onPressed: () {
        setState(() {
          showCheckboxFilter = !showCheckboxFilter;
          if (showCheckboxFilter) showCheckboxOrder = false;
        });
      },
    );
  }

  _orderButton() {
    return IconButton(
      icon: Icon(Icons.storage),
      tooltip: "Ordenar",
      onPressed: () {
        setState(() {
          showCheckboxOrder = !showCheckboxOrder;
          if (showCheckboxOrder) showCheckboxFilter = false;
        });
      },
    );
  }

  _checkboxFilter(BuildContext context) {
    return Container(
      key: ValueKey<bool>(showCheckboxFilter),
      width: MediaQuery.of(this.context).size.width - 80,
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.grey[200]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _filter.keys
            .map<Widget>((String key) => CheckboxListTile(
                  title: _text(key),
                  value: _filter[key],
                  onChanged: (bool change) {
                    setState(() {
                      _filter.forEach((k, v) {
                        _filter[k] = false;
                      });
                      _orderBy.forEach((k, v) {
                        _orderBy[k] = false;
                      });
                      _filter[key] = change;
                      if (change) {
                        _choiceFilter = "Categoria";
                        _choiceIncident = key;
                      } else if (_filter[_choiceIncident] == false) {
                        _choiceFilter = null;
                        _choiceIncident = null;
                      }
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  _checkboxOrder(BuildContext context) {
    return Container(
      key: ValueKey<bool>(showCheckboxOrder),
      width: MediaQuery.of(this.context).size.width - 80,
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.grey[200]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _orderBy.keys
            .map<Widget>((String key) => CheckboxListTile(
                  title: _text(key),
                  value: _orderBy[key],
                  onChanged: (bool change) {
                    setState(() {
                      _filter.forEach((k, v) {
                        _filter[k] = false;
                      });
                      _orderBy.forEach((k, v) {
                        _orderBy[k] = false;
                      });
                      _orderBy[key] = change;
                      if (change)
                        _choiceFilter = key;
                      else if (_orderBy[_choiceFilter] == false)
                        _choiceFilter = null;
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  _checkboxAnimated(BuildContext context, String type) {
    Widget checkbox;
    switch (type) {
      case "Ordem":
        checkbox = showCheckboxOrder
            ? _checkboxOrder(context)
            : Container(
                key: ValueKey<bool>(showCheckboxOrder),
              );
        break;
      case "Filtro":
        checkbox = showCheckboxFilter
            ? _checkboxFilter(context)
            : Container(
                key: ValueKey<bool>(showCheckboxFilter),
              );
        break;
      default:
        checkbox = Container();
        break;
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      child: checkbox,
    );
  }

  _text(String string) {
    return Text(
      string,
      style: TextStyle(fontSize: 20),
    );
  }

  _order(String type, {String specif}) {
    print("base order: " + this.widget.base);
    switch (type) {
      case "Data da ocorrencia":
        return Firestore.instance
            .collection('notification')
            .orderBy("occurrenceDate", descending: true)
            .where("base", isEqualTo: this.widget.base)
            .snapshots();
        break;
      case "Idade":
        return Firestore.instance
            .collection('notification')
            .orderBy("age")
            .where("base", isEqualTo: this.widget.base)
            .snapshots();
        break;
      case "Categoria":
        return Firestore.instance
            .collection('notification')
            .where("incident", isEqualTo: specif)
            .where("base", isEqualTo: this.widget.base)
            .snapshots();
        break;
      default: //Ordena por data de criação
        return Firestore.instance
            .collection('notification')
            .orderBy("createdAt", descending: true)
            .where("base", isEqualTo: this.widget.base)
            .snapshots();
        break;
    }
  }

  _listNotify(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((DocumentSnapshot doc) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DetailsNotice(doc)));
        },
        child: CardNotify(doc),
      );
    }).toList();
  }
}

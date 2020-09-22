import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noti_samu/components/cardNotify.dart';
import 'package:noti_samu/screens/Admin/detailsNotice.dart';
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
    "Circunstância notificável": false,
    "Quase erro": false,
  };

  Map<String, bool> _orderBy = {
    "Data de ocorrência": false,
    "Idade": false,
  };

  String _choiceFilter;
  String _choiceIncident;
  bool showCheckboxFilter = false;
  bool showCheckboxOrder = false;

  bool admin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
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
      child: StreamBuilder<QuerySnapshot>(
        stream: _order(
          _choiceFilter,
          this.widget.base,
          specif: _choiceIncident,
        ),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print("Snapshot ${snapshot.data}");
          if (snapshot.hasError) _snapshotError(snapshot);

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;

            case ConnectionState.none:
              _snapshotEmpty();
              break;

            case ConnectionState.active:
              return Center(
                child: ListView(
                  children: _listNotify(snapshot),
                ),
              );
              break;

            default:
              _snapshotEmpty();
              break;
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
                        _filter[k] = false; //reseta todo filtro
                      });
                      _orderBy.forEach((k, v) {
                        _orderBy[k] = false; //reseta toda ordem
                      });
                      _filter[key] = change;
                      if (change) {
                        //se change for true filtra por categoria e o tipo de incidente
                        _choiceFilter = "Classificação";
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
                        _filter[k] = false; //reseta todo filtro
                      });
                      _orderBy.forEach((k, v) {
                        _orderBy[k] = false; // reseta toda ordem
                      });
                      _orderBy[key] = change;
                      if (change) // se change for true filtra pela ordem escolhida
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

  _order(String type, String base, {String specif}) {
    var dataBase;

    if (base.compareTo("geral") == 0) {
      dataBase = Firestore.instance.collection('notification');
      admin = true;
    } else {
      dataBase = Firestore.instance
          .collection('notification')
          .where("base", isEqualTo: base);
      admin = false;
    }

    switch (type) {
      case "Data da ocorrência":
        return dataBase.orderBy("occurrenceDate", descending: true).snapshots();
        break;
      case "Idade":
        return dataBase.orderBy("age").snapshots();
        break;
      case "Classificação":
        return dataBase
            .orderBy("createdAt", descending: true)
            .where("classification", isEqualTo: specif)
            .snapshots();
        break;
      default: //Ordena por data de criação
        return dataBase.orderBy("createdAt", descending: true).snapshots();
        break;
    }
  }

  _listNotify(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((DocumentSnapshot doc) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsNotice(doc, admin)));
        },
        child: CardNotify(doc),
      );
    }).toList();
  }

  _snapshotError(AsyncSnapshot snapshot) {
    return Container(
      child: Center(
        child: _text('Erro: ${snapshot.error}'),
      ),
    );
  }

  _snapshotEmpty() {
    return Center(
      child: Text(
        "Nenhuma notificação foi encontrada.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

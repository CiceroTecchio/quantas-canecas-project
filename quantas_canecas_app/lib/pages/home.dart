import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quantas_canecas_app/models/caneca_model.dart';
import 'package:quantas_canecas_app/services/canecas_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FToast fToast = FToast();
  int _canecas = 0;
  int _typeOfIcon = 0;
  bool _visibleIcon = false;
  bool _buttonsDisabled = false;
  Timer _timerForIconCanecas = Timer.periodic(Duration(seconds: 0), (timer) {});

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    Timer.periodic(Duration(seconds: 3), (timer) async {
      CanecaModel caneca = await requestBuscarCaneca(1);
      if (caneca.quantidade != _canecas) {
        updateCanecas(caneca.quantidade);
      }
    });
  }

  _showToast(String message, String type) {
    fToast.removeCustomToast();
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: type == "success" ? Colors.greenAccent : Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(type == "success" ? Icons.check : Icons.close),
          SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  void aumentarCaneca() async {
    setState(() {
      _buttonsDisabled = true;
    });
    try {
      var response = await requestAumentarCaneca(1);
      updateCanecas(response['quantidade']);
      _showToast("Quantidade aumentada.", "success");
    } on Exception catch (_) {
      _showToast("Falha ao aumentar quantidade.", "error");
    }
    setState(() {
      _buttonsDisabled = false;
    });
  }

  void diminuirCaneca() async {
    setState(() {
      _buttonsDisabled = true;
    });
    try {
      var response = await requestDiminuirCaneca(1);
      updateCanecas(response['quantidade']);
      _showToast("Quantidade diminuida.", "success");
    } on Exception catch (_) {
      _showToast("Falha ao diminuir quantidade.", "error");
    }
    setState(() {
      _buttonsDisabled = false;
    });
  }

  void updateCanecas(int quantidade) {
    _timerForIconCanecas.cancel();
    setState(() {
      _typeOfIcon = quantidade >= _canecas ? 1 : 0;
      _canecas = quantidade;
      _visibleIcon = true;
    });

    _timerForIconCanecas = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _visibleIcon = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Canecas',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text('$_canecas',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500)),
                      ),
                      Visibility(
                        child: Icon(
                          _typeOfIcon == 0
                              ? Icons.trending_down
                              : Icons.trending_up,
                          color: _typeOfIcon == 0 ? Colors.red : Colors.green,
                          size: 25.0,
                        ),
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: _visibleIcon,
                      ),
                    ]),
                Text('Canecas',
                    style: TextStyle(fontSize: 30, color: Colors.black)),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlinedButton.icon(
                        label: Text('ADICIONAR',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        icon: _buttonsDisabled
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                                height: 20.0,
                                width: 20.0,
                              )
                            : Icon(Icons.add, size: 25),
                        style: OutlinedButton.styleFrom(
                            primary: Colors.green,
                            fixedSize: Size.fromHeight(50)),
                        onPressed: () {
                          _buttonsDisabled ? null : aumentarCaneca();
                        },
                      ),
                      Container(width: 10),
                      OutlinedButton.icon(
                        label: Text('REMOVER',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        icon: _buttonsDisabled
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                                height: 20.0,
                                width: 20.0,
                              )
                            : Icon(Icons.remove, size: 25),
                        style: OutlinedButton.styleFrom(
                            primary: Colors.red,
                            fixedSize: Size.fromHeight(50)),
                        onPressed: () {
                          _buttonsDisabled ? null : diminuirCaneca();
                        },
                      ),
                    ],
                  ),
                ),
                Text('Feito por Cícero I. Tecchio',
                    style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ));
  }
}

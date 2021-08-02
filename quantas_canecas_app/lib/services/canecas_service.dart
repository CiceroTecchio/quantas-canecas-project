import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quantas_canecas_app/models/caneca_model.dart';

String serverUrl = '10.0.0.107';

Future<CanecaModel> requestBuscarCaneca(int idCaneca) async {
  var url =
      Uri.http(serverUrl + ':8000', '/api/canecas/' + idCaneca.toString());

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var caneca = CanecaModel.fromJson(jsonDecode(response.body));
    return caneca;
  } else {
    throw Exception("Falha na request");
  }
}

requestAumentarCaneca(int idCaneca) async {
  var url = Uri.http(
      serverUrl + ':8000', '/api/canecas/' + idCaneca.toString() + '/aumentar');

  var response = await http.post(url);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Falha na request");
  }
}

requestDiminuirCaneca(int idCaneca) async {
  var url = Uri.http(
      serverUrl + ':8000', '/api/canecas/' + idCaneca.toString() + '/diminuir');

  var response = await http.post(url);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Falha na request");
  }
}

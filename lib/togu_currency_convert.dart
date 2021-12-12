library togu_currency_convert;

import 'dart:convert';

import 'package:http/http.dart';
import 'package:togu_currency_convert/api/api.dart';
import 'package:togu_currency_convert/global.dart';

class CurrencyConverter {
  String? symbol;
  double? value;

  CurrencyConverter({this.symbol, this.value});

  List<String> getCurrency() => listCurrency;

  Future<double?> convert(
      {required String from,
      required String to,
      required double amount}) async {
    Response response = await Api().getData(from: from);

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);

      double result = map['data'][to] * amount;

      return double.parse((result).toStringAsFixed(2));
    }
  }
}

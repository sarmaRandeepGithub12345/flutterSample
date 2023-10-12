import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:project/modals/Firstmodel.dart';

class CurrencyApi {
  static Future<FirstModal> fetchRates() async {
    const url =
        'https://openexchangerates.org/api/latest.json?app_id=bc3ccd46387a4d148bef5eb1ab1b42f4';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final obj = new FirstModal(
        disclaimer: json['disclaimer'],
        license: json['license'],
        timestamp: json['timestamp'],
        base: json['base'],
        rates: json['rates']);

    return obj;
    //final results = json['rates'];
  }
}

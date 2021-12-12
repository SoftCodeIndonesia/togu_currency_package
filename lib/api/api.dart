import 'package:http/http.dart';

class Api {
  final String _url =
      'https://freecurrencyapi.net/api/v2/latest?apikey=dfd423f0-582e-11ec-be06-3d0bad82a6b7&base_currency';
  final String _accessKey = 'access_key=b7f34b4f4248f98717b0cc12b8300df2';
  var client = Client();

  Future<Response> getData({required String from}) async {
    return await client.get(Uri.parse("$_url=$from"));
  }
}

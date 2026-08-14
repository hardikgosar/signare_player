import 'package:http/http.dart' as http;

class AppHttpClient {
  final http.Client client;

  AppHttpClient({http.Client? client}) : client = client ?? http.Client();

  Future<http.Response> get(Uri uri) {
    return client.get(uri);
  }

  void dispose() => client.close();
}

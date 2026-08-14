// import 'package:http/http.dart' as http;

import '../../../../core/error/app_exception.dart';
import '../../../../core/network/http_client.dart';

class MediaRemoteDataSource {
  final AppHttpClient httpClient;

  MediaRemoteDataSource({required this.httpClient});

  Future<List<int>> download(String url) async {
    try {
      final response = await httpClient.get(Uri.parse(url));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw DownloadException(
          'Download failed with status ${response.statusCode}: $url',
        );
      }

      if (response.bodyBytes.isEmpty) {
        throw DownloadException('Downloaded file is empty: $url');
      }

      return response.bodyBytes;
    } on AppException {
      rethrow;
    } catch (error) {
      throw DownloadException('Unable to download $url: $error');
    }
  }
}

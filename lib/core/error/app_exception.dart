class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

class DataException extends AppException {
  const DataException(super.message);
}

class DownloadException extends AppException {
  const DownloadException(super.message);
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}
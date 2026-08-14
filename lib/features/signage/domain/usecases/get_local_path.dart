
import '../repositories/signage_repository.dart';

class GetLocalPath {
  final SignageRepository repository;
  GetLocalPath(this.repository);

  Future<String> call(String url) {
    return repository.getLocalPath(url);
  }
}
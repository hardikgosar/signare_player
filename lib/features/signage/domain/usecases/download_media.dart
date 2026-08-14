
import '../entities/media_content.dart';
import '../repositories/signage_repository.dart';

class DownloadMedia{
  final SignageRepository repository;
  DownloadMedia(this.repository);

  Future<void> call(List<MediaContent> contents) {
    return repository.downloadAllMedia(contents);
  }
}
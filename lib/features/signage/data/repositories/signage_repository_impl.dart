import '../../domain/entities/media_content.dart';
import '../../domain/repositories/signage_repository.dart';
import '../datasources/content_local_datasource.dart';
import '../datasources/media_local_datasource.dart';
import '../datasources/media_remote_datasource.dart';

class SignageRepositoryImpl implements SignageRepository {
  final ContentLocalDataSource contentDataSource;
  final MediaRemoteDataSource mediaRemoteDataSource;
  final MediaLocalDataSource mediaLocalDataSource;

  SignageRepositoryImpl({
    required this.contentDataSource,
    required this.mediaRemoteDataSource,
    required this.mediaLocalDataSource,
  });

  @override
  Future<List<MediaContent>> fetchMediaContent() {
    return contentDataSource.getContent();
  }

  @override
  Future<void> downloadAllMedia(List<MediaContent> contents) async {
    final mediaItems = _flatten(contents);
    final uniqueUrls = mediaItems
        .map((item) => item.url)
        .where((url) => url.isNotEmpty)
        .toSet();

    await Future.wait(
      uniqueUrls.map(_ensureCached),
    );
  }

  Future<void> _ensureCached(String url) async {
    if (await mediaLocalDataSource.isCached(url)) {
      return;
    }

    final bytes = await mediaRemoteDataSource.download(url);
    await mediaLocalDataSource.save(url, bytes);
  }

  @override
  Future<String> getLocalPath(String url) {
    return mediaLocalDataSource.getLocalPath(url);
  }

  List<MediaContent> _flatten(List<MediaContent> contents) {
    final result = <MediaContent>[];

    for (final content in contents) {
      if (content.isCustom) {
        result.addAll(_flatten(content.custom));
      } else {
        result.add(content);
      }
    }

    return result;
  }
}

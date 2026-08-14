

import '../entities/media_content.dart';

abstract interface class SignageRepository {
Future<List<MediaContent>> fetchMediaContent();

Future<void> downloadAllMedia(List<MediaContent> contents);

Future<String> getLocalPath(String url);
}
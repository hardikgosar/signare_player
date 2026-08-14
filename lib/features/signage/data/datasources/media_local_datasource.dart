import 'dart:io';

import 'package:signare_player/core/storage/local_storage.dart';

import '../../../../core/error/app_exception.dart';

import '../../../../core/utils/file_utils.dart';

class MediaLocalDataSource {
  final LocalStorageService storageService;

  MediaLocalDataSource({required this.storageService});

  Future<String> getLocalPath(String url) async {
    final directory = await storageService.getMediaDirectory();
    return '${directory.path}/${FileUtils.generateFileNameFromUrl(url)}';
  }

  Future<bool> isCached(String url) async {
    final path = await getLocalPath(url);
    final file = File(path);
    return file.existsSync() && await file.length() > 0;
  }

  Future<String> save(String url, List<int> bytes) async {
    final path = await getLocalPath(url);
    final file = File(path);

    try {
      final tempFile = File('$path.part');
      await tempFile.writeAsBytes(bytes, flush: true);

      if (await file.exists()) {
        await file.delete();
      }

      await tempFile.rename(path);
      return path;
    } catch (error) {
      throw CacheException('Unable to save media locally: $error');
    }
  }
}

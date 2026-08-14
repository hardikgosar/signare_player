import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  Future<Directory> getMediaDirectory() async {
    final root = await getApplicationDocumentsDirectory();
    final directory = Directory('${root.path}/digital_signage_media');

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    return directory;
  }
}

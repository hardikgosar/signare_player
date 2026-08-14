

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/app_exception.dart';
import '../models/media_content_model.dart';

/// The assignment supplies the JSON as content rather than an API endpoint.
/// Therefore the playlist itself is bundled as an asset, while all media files
/// are fetched over HTTP and cached locally before playback.
class ContentLocalDataSource {
  Future<List<MediaContentModel>> getContent() async {
    try {
      final jsonString = await rootBundle.loadString(
        AppConstants.assetsPath,
      );
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      final result = decoded['result'] as List<dynamic>? ?? const [];

      return result
          .map((item) => MediaContentModel.fromJson(item as Map<String, dynamic>))
          .toList(growable: false);
    } catch (error) {
      throw DataException('Unable to load content: $error');
    }
  }
}
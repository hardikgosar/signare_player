import 'package:flutter/material.dart';

import '../../domain/entities/media_content.dart';
import '../../domain/usecases/get_local_path.dart';
import 'custom_media_layout.dart';
import 'local_image_media.dart';
import 'local_video_media.dart';

class MediaPlayer extends StatelessWidget {
  final MediaContent content;
  final GetLocalPath getLocalPath;
  final VoidCallback onComplete;

  const MediaPlayer({
    super.key,
    required this.content,
    required this.getLocalPath,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    switch (content.type) {
      case MediaType.image:
        return LocalImageMedia(
          url: content.url,
          getLocalPath: getLocalPath,
          onComplete: onComplete,
        );
      case MediaType.video:
        return LocalVideoMedia(
          url: content.url,
          getLocalPath: getLocalPath,
          onComplete: onComplete,
        );
      case MediaType.custom:
        return CustomMediaLayout(
          content: content,
          getLocalPath: getLocalPath,
          onComplete: onComplete,
        );
    }
  }
}

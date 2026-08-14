import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/media_content.dart';
import '../../domain/usecases/get_local_path.dart';
import 'local_image_media.dart';
import 'local_video_media.dart';

class CustomMediaLayout extends StatefulWidget {
  final MediaContent content;
  final GetLocalPath getLocalPath;
  final VoidCallback onComplete;

  const CustomMediaLayout({
    super.key,
    required this.content,
    required this.getLocalPath,
    required this.onComplete,
  });

  @override
  State<CustomMediaLayout> createState() => _CustomMediaLayoutState();
}

class _CustomMediaLayoutState extends State<CustomMediaLayout> {
  Timer? _imageTimer;
  int _imageOffset = 0;

  List<MediaContent> get _images => widget.content.custom
      .where((item) => item.type == MediaType.image)
      .toList(growable: false);

  MediaContent? get _video {
    for (final item in widget.content.custom) {
      if (item.type == MediaType.video) {
        return item;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _imageTimer = Timer.periodic(
      AppConstants.customImageDuration,
      (_) {
        if (!mounted || _images.isEmpty) return;
        setState(() {
          _imageOffset = (_imageOffset + 1) % _images.length;
        });
      },
    );
  }

  MediaContent _imageAt(int sectionIndex) {
    return _images[(_imageOffset + sectionIndex) % _images.length];
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_video == null || _images.length < 3) {
      return const ColoredBox(color: Colors.black);
    }

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: LocalVideoMedia(
                  url: _video!.url,
                  getLocalPath: widget.getLocalPath,
                  durationDrivenByVideo: true,
                  onComplete: widget.onComplete,
                ),
              ),
              Expanded(
                child: LocalImageMedia(
                  key: ValueKey(_imageAt(0).url),
                  url: _imageAt(0).url,
                  getLocalPath: widget.getLocalPath,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: LocalImageMedia(
                  key: ValueKey(_imageAt(1).url),
                  url: _imageAt(1).url,
                  getLocalPath: widget.getLocalPath,
                ),
              ),
              Expanded(
                child: LocalImageMedia(
                  key: ValueKey(_imageAt(2).url),
                  url: _imageAt(2).url,
                  getLocalPath: widget.getLocalPath,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

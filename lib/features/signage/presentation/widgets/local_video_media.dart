import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/usecases/get_local_path.dart';

class LocalVideoMedia extends StatefulWidget {
  final String url;
  final GetLocalPath getLocalPath;
  final bool durationDrivenByVideo;
  final VoidCallback onComplete;

  const LocalVideoMedia({
    super.key,
    required this.url,
    required this.getLocalPath,
    required this.onComplete,
    this.durationDrivenByVideo = false,
  });

  @override
  State<LocalVideoMedia> createState() => _LocalVideoMediaState();
}

class _LocalVideoMediaState extends State<LocalVideoMedia> {
  VideoPlayerController? _controller;
  Timer? _normalDurationTimer;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final localPath = await widget.getLocalPath(widget.url);
      if (!mounted) return;

      final controller = VideoPlayerController.file(File(localPath));
      _controller = controller;
      controller.addListener(_onVideoChanged);

      await controller.initialize();
      if (!mounted) return;

      await controller.play();

      if (!widget.durationDrivenByVideo) {
        _normalDurationTimer = Timer(
          AppConstants.normalContentDuration,
          _complete,
        );
      }

      setState(() {});
    } catch (_) {
      _complete();
    }
  }

  void _onVideoChanged() {
    final controller = _controller;
    if (controller == null || !widget.durationDrivenByVideo) return;

    if (controller.value.isInitialized &&
        controller.value.position >= controller.value.duration &&
        !controller.value.isPlaying) {
      _complete();
    }
  }

  void _complete() {
    if (_completed) return;
    _completed = true;
    widget.onComplete();
  }

  @override
  void dispose() {
    _normalDurationTimer?.cancel();
    _controller?.removeListener(_onVideoChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (controller == null || !controller.value.isInitialized) {
      return const ColoredBox(color: Colors.black);
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.contain,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }
}

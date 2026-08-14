import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/usecases/get_local_path.dart';

class LocalImageMedia extends StatefulWidget {
  final String url;
  final GetLocalPath getLocalPath;
  final VoidCallback? onComplete;
  final Duration? duration;

  const LocalImageMedia({
    super.key,
    required this.url,
    required this.getLocalPath,
    this.onComplete,
    this.duration,
  });

  @override
  State<LocalImageMedia> createState() => _LocalImageMediaState();
}

class _LocalImageMediaState extends State<LocalImageMedia> {
  Timer? _timer;
  Future<String>? _localPathFuture;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _localPathFuture = widget.getLocalPath(widget.url);

    if (widget.onComplete != null) {
      _timer = Timer(
        widget.duration ?? AppConstants.normalContentDuration,
        _complete,
      );
    }
  }

  void _complete() {
    if (_completed) return;
    _completed = true;
    widget.onComplete?.call();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _localPathFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done ||
            !snapshot.hasData) {
          return const ColoredBox(color: Colors.black);
        }

        return SizedBox.expand(
          child: Image.file(
            File(snapshot.data!),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const ColoredBox(
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}

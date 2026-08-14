import 'package:flutter/material.dart';

class DownloadSplash extends StatelessWidget {
  const DownloadSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.black,
      child: Center(
        child: FlutterLogo(size: 96),
      ),
    );
  }
}

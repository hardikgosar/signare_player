import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/signage_bloc.dart';
import '../bloc/signage_event.dart';
import '../bloc/signage_state.dart';
import '../widgets/download_splash.dart';
import 'signage_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignageBloc, SignageState>(
      builder: (context, state) {
        switch (state.status) {
          case SignageStatus.initial:
          case SignageStatus.downloading:
            return const DownloadSplash();
          case SignageStatus.ready:
          case SignageStatus.playing:
            return const SignagePage();
          case SignageStatus.failure:
            return _ErrorView(
              message: state.errorMessage ?? 'Unable to prepare media.',
              onRetry: () {
                context.read<SignageBloc>().add(const InitializeSignage());
              },
            );
        }
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

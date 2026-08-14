import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_local_path.dart';
import '../bloc/signage_bloc.dart';
import '../bloc/signage_event.dart';
import '../bloc/signage_state.dart';
import '../widgets/media_player.dart';

class SignagePage extends StatelessWidget {
  const SignagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final getLocalPath = context.read<GetLocalPath>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<SignageBloc, SignageState>(
        buildWhen: (previous, current) =>
            previous.currentIndex != current.currentIndex ||
            previous.status != current.status,
        builder: (context, state) {
          final content = state.currentContent;

          if (content == null) {
            return const ColoredBox(color: Colors.black);
          }

          return MediaPlayer(
            key: ValueKey('${state.currentIndex}_${content.url}_${content.type.name}'),
            content: content,
            getLocalPath: getLocalPath,
            onComplete: () {
              context.read<SignageBloc>().add(const ShowNextContent());
            },
          );
        },
      ),
    );
  }
}

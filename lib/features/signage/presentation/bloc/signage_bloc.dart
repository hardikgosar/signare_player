

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/download_media.dart';

import '../../domain/usecases/get_content.dart';
import 'signage_event.dart';
import 'signage_state.dart';

class SignageBloc extends Bloc<SignageEvent, SignageState> {
  final GetContent getContent;
  final DownloadMedia downloadMedia;

  SignageBloc({
    required this.getContent,
    required this.downloadMedia,
  }) : super(const SignageState()) {
    on<InitializeSignage>(_onInitialize);
    on<StartPlayback>(_onStartPlayback);
    on<ShowNextContent>(_onShowNextContent);
  }

  Future<void> _onInitialize(
    InitializeSignage event,
    Emitter<SignageState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SignageStatus.downloading,
        clearError: true,
      ),
    );

    try {
      final contents = await getContent();
      await downloadMedia(contents);

      emit(
        state.copyWith(
          status: SignageStatus.ready,
          contents: contents,
          currentIndex: 0,
          clearError: true,
        ),
      );

      add(const StartPlayback());
    } catch (error) {
      emit(
        state.copyWith(
          status: SignageStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void _onStartPlayback(
    StartPlayback event,
    Emitter<SignageState> emit,
  ) {
    if (state.contents.isEmpty) return;

    emit(
      state.copyWith(
        status: SignageStatus.playing,
      ),
    );
  }

  void _onShowNextContent(
    ShowNextContent event,
    Emitter<SignageState> emit,
  ) {
    if (state.contents.isEmpty) return;

    final nextIndex = (state.currentIndex + 1) % state.contents.length;

    emit(
      state.copyWith(
        status: SignageStatus.playing,
        currentIndex: nextIndex,
      ),
    );
  }
}

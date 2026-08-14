import 'package:equatable/equatable.dart';

import '../../domain/entities/media_content.dart';

enum SignageStatus {
  initial,
  downloading,
  ready,
  playing,
  failure,
}

class SignageState extends Equatable {
  final SignageStatus status;
  final List<MediaContent> contents;
  final int currentIndex;
  final String? errorMessage;

  const SignageState({
    this.status = SignageStatus.initial,
    this.contents = const [],
    this.currentIndex = 0,
    this.errorMessage,
  });

  MediaContent? get currentContent {
    if (contents.isEmpty || currentIndex >= contents.length) {
      return null;
    }
    return contents[currentIndex];
  }

  SignageState copyWith({
    SignageStatus? status,
    List<MediaContent>? contents,
    int? currentIndex,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SignageState(
      status: status ?? this.status,
      contents: contents ?? this.contents,
      currentIndex: currentIndex ?? this.currentIndex,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        contents,
        currentIndex,
        errorMessage,
      ];
}

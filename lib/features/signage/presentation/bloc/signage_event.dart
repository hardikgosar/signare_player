import 'package:equatable/equatable.dart';

sealed class SignageEvent extends Equatable {
  const SignageEvent();

  @override
  List<Object?> get props => const [];
}

class InitializeSignage extends SignageEvent {
  const InitializeSignage();
}

class StartPlayback extends SignageEvent {
  const StartPlayback();
}

class ShowNextContent extends SignageEvent {
  const ShowNextContent();
}

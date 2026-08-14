# Signage Player

A Flutter digital signage player that pre-downloads the complete media playlist to local storage and then plays the content in an infinite loop.

## Features

- Flutter application using BLoC for state management.
- Clean, feature-based architecture with separation of presentation, domain, and data layers.
- Media downloads are performed using the `http` package.
- Media is cached locally before playback starts.
- Missing media files are downloaded concurrently.
- Previously downloaded media is reused instead of downloading it again.
- Image content is displayed for 10 seconds.
- Video content is played automatically from local storage and limited to 10 seconds.
- Custom content displays one video and three images simultaneously in four equal sections.
- Images in the custom layout rotate every 5 seconds while the video continues playing.
- Playback works without network access after all required media has been cached.
- Video controllers are disposed when no longer needed.

## Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── error/
│   ├── network/
│   ├── storage/
│   └── di/
│   └── utils/
│
├── features/
│   └── signage/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       │
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
│
├── app.dart
└── main.dart
```

### Layer responsibilities

- **Presentation:** Flutter pages, widgets, and BLoC state management.
- **BLoC:** Coordinates application state and the download/playback flow.
- **Domain:** Contains entities, repository contracts, and use cases.
- **Data:** Handles JSON models, HTTP/network access, local media storage, and repository implementations.
- **Core:** Shared constants, errors, networking/storage helpers, and utilities.

## Requirements

Install the following before running the project:

- Flutter SDK
- Dart SDK (included with Flutter)
- Android Studio / Android SDK for Android builds
- Xcode for iOS builds on macOS

Verify the Flutter environment:

```bash
flutter doctor
```

## How to Run

### 1. Clone the repository

```bash
git clone https://github.com/hardikgosar/signare_player.git
cd digital_signage_player
```

### 2. Get dependencies

```bash
flutter pub get
```

### 3. Check the project

```bash
flutter analyze
```

### 4. Run the application

```bash
flutter run
```

For a specific device:

```bash
flutter devices
flutter run -d <device-id>
```

## Build APK

For a release APK:

```bash
flutter build apk --release
```

The generated APK can be found under:

```text
build/app/outputs/flutter-apk/
```


## Offline Playback

The application downloads the required media before playback begins.

Media is stored locally and playback uses the downloaded local files rather than the original network URLs.

Once the required media has been successfully cached, the player can continue playing the cached content without requiring network access during playback.


## Packages

Main packages used by the project include:

- `flutter_bloc` - BLoC state management
- `equatable` - Value equality for BLoC states/events
- `http` - Network requests and media downloads
- `video_player` - Local video playback
- `path_provider` - Application storage directory
- `path` - File path handling

## Notes

The project is intended to run as a fullscreen digital signage application. The download screen is intentionally minimal and displays a black background with the Flutter logo until the required media is ready.



enum MediaType { image, video, custom, }

class MediaContent {
  final MediaType type;
  final String url;
  final List<MediaContent> custom;

  const MediaContent({
    required this.type,
    required this.url,
    this.custom = const [],
  });

  bool get isCustom => type == MediaType.custom;
}

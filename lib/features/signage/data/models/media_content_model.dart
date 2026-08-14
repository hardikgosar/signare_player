import '../../domain/entities/media_content.dart';

class MediaContentModel extends MediaContent {
  const MediaContentModel({
    required super.type,
    required super.url,
    super.custom,
  });

  factory MediaContentModel.fromJson(Map<String, dynamic> json) {
    final typeValue = json['type']?.toString();
    final type = switch (typeValue) {
      'image' => MediaType.image,
      'video' => MediaType.video,
      'custom' => MediaType.custom,
      _ => throw FormatException('Unsupported media type: $typeValue'),
    };

    final customItems = (json['custom'] as List<dynamic>? ?? const [])
        .map((item) => MediaContentModel.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);

    return MediaContentModel(
      type: type,
      url: json['url']?.toString() ?? '',
      custom: customItems,
    );
  }
}

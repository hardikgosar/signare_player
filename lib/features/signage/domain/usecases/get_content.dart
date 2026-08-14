
import '../entities/media_content.dart';
import '../repositories/signage_repository.dart';

class GetContent {
  final SignageRepository repository;
  GetContent(this.repository);

  Future<List<MediaContent>> call() {
    return repository.fetchMediaContent();
  }
} 
  

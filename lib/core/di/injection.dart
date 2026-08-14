import '../../features/signage/data/datasources/content_local_datasource.dart';
import '../../features/signage/data/datasources/media_local_datasource.dart';
import '../../features/signage/data/datasources/media_remote_datasource.dart';
import '../../features/signage/data/repositories/signage_repository_impl.dart';
import '../../features/signage/domain/repositories/signage_repository.dart';
import '../network/http_client.dart';
import '../storage/local_storage.dart';


class AppDependencies {
  late final AppHttpClient httpClient;
  late final LocalStorageService storageService;

  late final ContentLocalDataSource contentDataSource;
  late final MediaRemoteDataSource mediaRemoteDataSource;
  late final MediaLocalDataSource mediaLocalDataSource;

  late final SignageRepository signageRepository;

  AppDependencies() {
    _initialize();
  }

  void _initialize() {
    httpClient = AppHttpClient();
    storageService = LocalStorageService();

    contentDataSource = ContentLocalDataSource();

    mediaRemoteDataSource = MediaRemoteDataSource(
      httpClient: httpClient,
    );

    mediaLocalDataSource = MediaLocalDataSource(
      storageService: storageService,
    );

    signageRepository = SignageRepositoryImpl(
      contentDataSource: contentDataSource,
      mediaRemoteDataSource: mediaRemoteDataSource,
      mediaLocalDataSource: mediaLocalDataSource,
    );
  }

  void dispose() {
    httpClient.dispose();
  }
}
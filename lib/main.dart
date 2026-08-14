import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
// import 'core/network/http_client.dart';
// import 'core/storage/local_storage.dart';
// import 'features/signage/data/datasources/content_local_datasource.dart';
// import 'features/signage/data/datasources/media_local_datasource.dart';
// import 'features/signage/data/datasources/media_remote_datasource.dart';
// import 'features/signage/data/repositories/signage_repository_impl.dart';
import 'features/signage/domain/repositories/signage_repository.dart';
import 'features/signage/domain/usecases/download_media.dart';
import 'features/signage/domain/usecases/get_content.dart';
import 'features/signage/domain/usecases/get_local_path.dart';
import 'features/signage/presentation/bloc/signage_bloc.dart';
import 'features/signage/presentation/bloc/signage_event.dart';
import 'features/signage/presentation/pages/root_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // final httpClient = AppHttpClient();
  // final storageService = LocalStorageService();

  // final contentDataSource = ContentLocalDataSource();
  // final mediaRemoteDataSource = MediaRemoteDataSource(httpClient: httpClient);
  // final mediaLocalDataSource = MediaLocalDataSource(
  //   storageService: storageService,
  // );

  // final SignageRepository repository = SignageRepositoryImpl(
  //   contentDataSource: contentDataSource,
  //   mediaRemoteDataSource: mediaRemoteDataSource,
  //   mediaLocalDataSource: mediaLocalDataSource,
  // );

  final dependencies = AppDependencies();

  runApp(SignageApp(repository: dependencies.signageRepository));
}

class SignageApp extends StatelessWidget {
  final SignageRepository repository;

  const SignageApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: repository),
        RepositoryProvider<GetContent>(create: (_) => GetContent(repository)),
        RepositoryProvider<DownloadMedia>(
          create: (_) => DownloadMedia(repository),
        ),
        RepositoryProvider<GetLocalPath>(
          create: (_) => GetLocalPath(repository),
        ),
      ],
      child: BlocProvider(
        create: (context) => SignageBloc(
          getContent: context.read<GetContent>(),
          downloadMedia: context.read<DownloadMedia>(),
        )..add(const InitializeSignage()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true),
          home: const RootPage(),
        ),
      ),
    );
  }
}

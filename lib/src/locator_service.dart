import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:web_test_app/src/data/data_sources/pixabay_api.dart';
import 'package:web_test_app/src/data/repositories/image_repository_impl.dart';
import 'package:web_test_app/src/domain/repositories/image_repository.dart';
import 'package:web_test_app/src/presentation/blocs/image_bloc/image_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<PixabayApi>(PixabayApi(sl<Dio>()));

  sl.registerSingleton<ImageRepository>(ImageRepositoryImpl(sl<PixabayApi>()));

  sl.registerSingleton<ImageBloc>(ImageBloc(sl<ImageRepository>()));
}

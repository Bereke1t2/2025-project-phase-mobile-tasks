// ignore: depend_on_referenced_packages
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/networks/networkinfo.dart';
import 'futures/product/data/data_sources/local/product_local_data_source.dart';
import 'futures/product/data/data_sources/remote/product_remote_data_sources.dart';
import 'futures/product/data/repositories/product_repository_impl.dart';
import 'futures/product/domain/repositories/product_repository.dart';
import 'futures/product/domain/useCases/delete_product_usecase.dart';
import 'futures/product/domain/useCases/get_product_usecase.dart';
import 'futures/product/domain/useCases/get_products_usecase.dart';
import 'futures/product/domain/useCases/insert_product_usecase.dart';
import 'futures/product/domain/useCases/update_product_usecase.dart';
import 'futures/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Product
  //bloc
  sl.registerFactory(
    () => ProductBloc(
      getAllProductsUseCase: sl(),
      getProductByIdUseCase: sl(),
      insertProductUseCase: sl(),
      deleteProductUseCase: sl(),
      updateProductUseCase: sl(),
    ),
  );
  //use cases
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductUseCase(sl()));
  sl.registerLazySingleton(() => InsertProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));
  //repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      sl(), // productRemoteDataSource
      sl(), // productLocalDataSource
      sl(), // networkInfo
    ),
  );
  //data sources
  sl.registerLazySingleton<ProductRemoteDataSources>(
    () => ProductRemoteDataSourcesImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSources>(
    () => ProductLocalDataSourceImpl(sl()),
  );
  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  //external
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => SharedPreferences.getInstance());
  sl.registerLazySingleton(() => Connectivity());
}
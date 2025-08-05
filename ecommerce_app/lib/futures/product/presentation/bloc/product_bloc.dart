import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
// import 'package:http/http.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/useCases/delete_product_usecase.dart';
import '../../domain/useCases/get_product_usecase.dart';
import '../../domain/useCases/get_products_usecase.dart';
import '../../domain/useCases/insert_product_usecase.dart';
import '../../domain/useCases/update_product_usecase.dart';
// import '../../domain/entities/product_entity.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getAllProductsUseCase;
  final GetProductUseCase getProductByIdUseCase;
  final InsertProductUseCase insertProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final UpdateProductUseCase updateProductUseCase;

  ProductBloc({
    required this.getAllProductsUseCase,
    required this.getProductByIdUseCase,
    required this.insertProductUseCase,
    required this.deleteProductUseCase,
    required this.updateProductUseCase,
  }) : super(ProductInitial()) {

    on<LoadAllProductsEvent>((event, emit) async {
      emit(LoadingState());
      await for (final state in getAllProducts(getAllProductsUseCase)) {
        emit(state);
      }
    });

    on<LoadSingleProductEvent>((event, emit) async {
      emit(LoadingState());
      await for (final state in getProductById(event.productId , getProductByIdUseCase)) {
        emit(state);
      }
      add(LoadAllProductsEvent());

    });
    on<InsertProductEvent>((event, emit) async {
      emit(LoadingState());
      await for (final state in insertProduct(event.product, insertProductUseCase)) {
        emit(state);
      }
      add(LoadAllProductsEvent());
    });
    on<DeleteProductEvent>((event, emit) async {
      emit(LoadingState());
      await for (final state in deleteProduct(event.productId , deleteProductUseCase)) {
        emit(state);
      }
      add(LoadAllProductsEvent());
    });
    on<UpdateProductEvent>((event, emit) async {
      emit(LoadingState());
      await for (final state in updateProduct(event.product , updateProductUseCase)) {
        emit(state);
      }
      add(LoadAllProductsEvent());
    });
  }
}

Stream<ProductState> getAllProducts(GetProductsUseCase getAllProductsUseCase) async* {
  final Either<Failure, List<ProductEntity>> products = await getAllProductsUseCase();
  yield* products.fold(
    (failure) async* {
      yield ErrorState(failure.message);
    },
    (productsList) async* {
      yield LoadedAllProductsState(productsList);
    },
  );
}

Stream<ProductState> getProductById(String productId , GetProductUseCase getProductByIdUseCase) async* {
  final Either<Failure, ProductEntity> product = await getProductByIdUseCase(productId);
  yield* product.fold(
    (failure) async* {
      yield ErrorState(failure.message);
    },
    (productEntity) async* {
      yield LoadedSingleProductState(productEntity);
    },
  );
}

Stream<ProductState> insertProduct(ProductEntity product, InsertProductUseCase insertProductUseCase) async* {
  final Either<Failure, void> result = await insertProductUseCase(product);
  yield* result.fold(
    (failure) async* {
      yield ErrorState(failure.message);
    },
    (_) async* {
      yield LoadedSuccessState();
    },
  );
}

Stream<ProductState> deleteProduct(String productId, DeleteProductUseCase deleteProductUseCase) async* {
  final Either<Failure, void> result = await deleteProductUseCase(productId);
  yield* result.fold(
    (failure) async* {
      yield ErrorState(failure.message);
    },
    (_) async* {
      yield LoadedSuccessState();
    },
  );
}

Stream<ProductState> updateProduct(ProductEntity product, UpdateProductUseCase updateProductUseCase) async* {
  final Either<Failure, void> result = await updateProductUseCase(product);
  yield* result.fold(
    (failure) async* {
      yield ErrorState(failure.message);
    },
    (_) async* {
      yield LoadedSuccessState();
    },
  );
}
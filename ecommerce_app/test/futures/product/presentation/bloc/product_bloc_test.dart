
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/futures/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/futures/product/domain/useCases/delete_product_usecase.dart';
import 'package:ecommerce_app/futures/product/domain/useCases/get_product_usecase.dart';
import 'package:ecommerce_app/futures/product/domain/useCases/get_products_usecase.dart';
import 'package:ecommerce_app/futures/product/domain/useCases/insert_product_usecase.dart';
import 'package:ecommerce_app/futures/product/domain/useCases/update_product_usecase.dart';
import 'package:ecommerce_app/futures/product/presentation/bloc/product_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([
  MockSpec<GetProductsUseCase>(),
  MockSpec<GetProductUseCase>(),
  MockSpec<InsertProductUseCase>(),
  MockSpec<DeleteProductUseCase>(),
  MockSpec<UpdateProductUseCase>(),
])

import 'product_bloc_test.mocks.dart';

void main() {
  late ProductBloc productBloc;

  setUp(() {
    productBloc = ProductBloc(
      getAllProductsUseCase: MockGetProductsUseCase(),
      getProductByIdUseCase: MockGetProductUseCase(),
      insertProductUseCase: MockInsertProductUseCase(),
      deleteProductUseCase: MockDeleteProductUseCase(),
      updateProductUseCase: MockUpdateProductUseCase(),
    );
  });

  tearDown(() {
    productBloc.close();
  });
  group('ProductBloc', () {
    test('initial state is ProductInitial', () {
      expect(productBloc.state, ProductInitial());
    });

    test('LoadAllProductsEvent emits LoadingState and then LoadedAllProductsState', () async {
      when(productBloc.getAllProductsUseCase()).thenAnswer((_) async => const Right([]));

      productBloc.add(LoadAllProductsEvent());

      await expectLater(
        productBloc.stream,
        emitsInOrder([LoadingState(), isA<LoadedAllProductsState>()]),
      );
    });
    test('LoadSingleProductEvent emits LoadingState and then LoadedSingleProductState', () async {
      final product = const ProductEntity(id: '1', name: 'Test', description: 'Test', price: 10.0, imageUrl: 'test.jpg');
      when(productBloc.getProductByIdUseCase('1')).thenAnswer((_) async => Right(product)); 

      productBloc.add(const LoadSingleProductEvent('1'));

      await expectLater(
        productBloc.stream,
        emitsInOrder([LoadingState(), isA<LoadedAllProductsState>()]),
      );
    });
    test('InsertProductEvent emits LoadingState and then ProductInsertedState', () async {
      final product = const ProductEntity(id: '1', name: 'Test', description: 'Test', price: 10.0, imageUrl: 'test.jpg');
      when(productBloc.insertProductUseCase(product)).thenAnswer((_) async => const Right(null));

      productBloc.add(InsertProductEvent(product));

      await expectLater(
        productBloc.stream,
        emitsInOrder([LoadingState(), isA<LoadedAllProductsState>()]),
      );
    });
    test('DeleteProductEvent emits LoadingState and then ProductDeletedState', () async {
      when(productBloc.deleteProductUseCase('1')).thenAnswer((_) async => const Right(null)); 
      productBloc.add(const DeleteProductEvent('1'));
      await expectLater(
        productBloc.stream,
        emitsInOrder([LoadingState(), isA<LoadedAllProductsState>()]),
      );
    });
    test('UpdateProductEvent emits LoadingState and then ProductUpdatedState', () async {
      final product = const ProductEntity(id: '1', name: 'Test', description: 'Test', price: 10.0, imageUrl: 'test.jpg');
      when(productBloc.updateProductUseCase(product)).thenAnswer((_) async => const Right(null));

      productBloc.add(UpdateProductEvent(product));

      await expectLater(
        productBloc.stream,
        emitsInOrder([LoadingState(), isA<LoadedAllProductsState>()]),
      );
    });

  });
}
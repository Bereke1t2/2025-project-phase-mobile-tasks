import '../../../data/models/product_model.dart';

abstract class ProductRemoteDataSources {
  Future<List<ProductModel>> fetchProducts();
  Future<ProductModel> fetchProductById(String id);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}
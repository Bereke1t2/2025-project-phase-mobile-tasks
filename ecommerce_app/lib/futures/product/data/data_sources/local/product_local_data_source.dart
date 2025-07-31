import '../../../data/models/product_model.dart';

abstract class ProductLocalDataSources {
  Future<List<ProductModel>> fetchProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<ProductModel> fetchProductById(String id);
  Future<void> addProduct(ProductModel product);
}
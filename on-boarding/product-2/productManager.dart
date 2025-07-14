import 'helper.dart';
import 'product.dart';
class Productmanager {
  Map products = {};

  void addProduct() {
    Product newProduct = getProductInput();
    products[newProduct.getProductName()] = newProduct;
    print('Product added successfully: ${newProduct.getProductName()}');
  }

  void removeProduct(String productName) {
    if (products.containsKey(productName)) {
      products.remove(productName);
      print('Product removed successfully: $productName');
    } else {
      print('Product not found: $productName');
    }
  }

  void updateProduct(String productName) {
    if (products.containsKey(productName)) {
      Product updatedProduct = getUpdatedProduct();
      if (updatedProduct.getProductName().isNotEmpty) {
        products[productName].setProductName(updatedProduct.getProductName());
      }
      if (updatedProduct.getProductDescription().isNotEmpty) {
        products[productName]?.setProductDescription(updatedProduct.getProductDescription());
      }
      if (updatedProduct.getProductPrice() > 0) {
        products[productName]?.setProductPrice(updatedProduct.getProductPrice());
      }
      print('Product updated successfully:');
      displayProduct(products[productName]);
    } else {
      print('Product not found: $productName');
    }
  }
  void getProduct(String productName) {
    if (products.containsKey(productName)) {
      displayProduct(products[productName]);
    } else {
      print('Product not found: $productName');
    }
  }


  void displayProducts() {
    if (products.isEmpty) {
      print('No products available.');
    } else {
      print('Available Products:');
      products.forEach((key, value) {
        displayProduct(value);
      });
    }
  }

}


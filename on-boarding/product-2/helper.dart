
import 'dart:io';
import 'product.dart';
import 'productManager.dart';


Product getProductInput(){
  String? name , description;
  double? price;

  print('please enter the product name:');
  name = stdin.readLineSync();
  print('please enter the product description:');
  description = stdin.readLineSync();
  print('please enter the product price:');
  price = double.tryParse(stdin.readLineSync() ?? '');
  return Product(name: name, description: description, price: price);
}


void displayProduct(Product product) {
  print('Product Details:');
  print('Name: ${product.getProductName()}');
  print('Description: ${product.getProductDescription()}');
  print('Price: \$${product.getProductPrice()}');
}


Product getUpdatedProduct(){
  print('Please enter the updated product details and leave blank if you want to keep the current value.');
  Product updatedProduct = getProductInput();
  return updatedProduct;
}


void start_app(Productmanager ecom){
  bool programEnd = false;
  while(!programEnd){
    print('1. Add Product');
    print('2. Remove Product');
    print('3. Update Product');
    print('4. Get single Product');
    print('5. Display Products');
    print('6. Exit');
    String? choice = stdin.readLineSync();
    switch(choice){
      case '1':
        ecom.addProduct();
        break;
      case '2':
        print('Enter product name to remove:');
        String? name = stdin.readLineSync();
        if (name == null || name.isEmpty) {
          print('Product name cannot be empty.');
          continue;
        }
        ecom.removeProduct(name);
        break;
      case '3':
        print('Enter product name to update:');
        String? name = stdin.readLineSync();
        if (name == null || name.isEmpty) {
          print('Product name cannot be empty.');
          continue;
        }
        ecom.updateProduct(name);
        break;
      case '4':
        print('Enter product name to get details:');
        String? name = stdin.readLineSync();
        if (name == null || name.isEmpty) {
          print('Product name cannot be empty.');
          continue;
        }
        ecom.getProduct(name);
        break;
      case '5':
        ecom.displayProducts();
        break;
      case '6':
        programEnd = true;
        break;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}
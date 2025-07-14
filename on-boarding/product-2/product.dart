
class Product {
  String? name , description;
  double? price;
  Product({this.name, this.description, this.price});

  @override
  String toString() {
    return 'Product{name: $name, description: $description, price: $price}';
  }

  String getProductName() {
    return name ?? 'Unknown Product';
  }
  String getProductDescription() {
    return description ?? 'No description available';
  }
  double getProductPrice() {
    return price ?? 0.0;
  }
  void setProductName(String name) {
    this.name = name;
  }
  void setProductDescription(String description) {
    this.description = description;
  }
  void setProductPrice(double price) {
    this.price = price;
  }

}



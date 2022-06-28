class Product {
Product({required this.id, required this.name, required this.price, required this.productGroupId, required this.rating, this.imageUrl});
  int id;
  int productGroupId;
  String name;
  double rating;
  double price;
  String? imageUrl;

}
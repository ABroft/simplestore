import 'package:simple_store/models/product.dart';

class Order {
  Order({required this.id, required this.number, required this.totalCost, required this.date, required this.productList});
  final int id;
  final String number;
  final double totalCost;
  final DateTime date;
  final List<Product> productList;
  
}
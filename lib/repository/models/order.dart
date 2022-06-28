

import 'package:simple_store/repository/models/product.dart';

class Order {
  Order({required this.id, required this.number, required this.totalCost, required this.date, required this.productList});
  int id;
  String number;
  double totalCost;
  DateTime date;
  List<Product> productList;
  
}
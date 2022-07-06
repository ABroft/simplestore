

import 'package:simple_store/repository/local_api/models/product.dart';

class DatumOrder {
  DatumOrder({this.id,  this.number,  this.totalCost,  this.date,  this.productList});
  final int? id;
  final String? number;
  final double? totalCost;
  final DateTime? date;
  final List<DatumProduct>? productList;
  
}
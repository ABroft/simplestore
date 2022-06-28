

import 'package:simple_store/repository/local_api/models/product.dart';

class DatumOrder {
  DatumOrder({this.id,  this.number,  this.totalCost,  this.date,  this.productList});
  int? id;
  String? number;
  double? totalCost;
  DateTime? date;
  List<DatumProduct>? productList;
  
}
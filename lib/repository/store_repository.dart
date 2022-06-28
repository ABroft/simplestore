import 'package:simple_store/repository/local_api/models/order.dart';
import 'package:simple_store/repository/local_api/models/product.dart';
import 'package:simple_store/repository/local_api/models/product_group.dart';
import 'package:simple_store/repository/local_api/store_api.dart';
import 'package:simple_store/repository/models/order.dart';
import 'package:simple_store/repository/models/product.dart';
import 'package:simple_store/repository/models/product_group.dart';
import 'package:simple_store/repository/models/user.dart';

class StoreRepository {
  StoreRepository({StoreApi? storeApi})
      : _storeApi = storeApi ?? StoreApi(),
        isLocalRep = (storeApi == null) ? true : false;

  final StoreApi _storeApi;
  final bool isLocalRep;

  Future<List<ProductGroup>> getProductGroupList() async {
    List<ProductGroup> list = [];

    final listFromApi = await _storeApi.fetchProductGroupList();

    for (DatumProductGroup g in listFromApi) {
      if (g.id == null || g.name == null || g.amount == null) {
        continue;
      }
      ProductGroup group = ProductGroup(
          id: g.id!, name: g.name!, amount: g.amount!, imageUrl: g.imageUrl);
      list.add(group);
    }
    return list;
  }

  Future<List<Product>> getGroup({required int groupid}) async {
    final listFromApi = await _storeApi.fetchGroup(groupid: groupid);
    return fromListToList(listFromApi: listFromApi);
  }

  Future<User?> getUserDetails({required int userId}) async {
    final user = await _storeApi.fetchUserDetail(userId: userId);
    if (user.id == null || user.name == null || user.surname == null) {
      return null;
    } else {
      return User(
          id: user.id!,
          name: user.name!,
          surname: user.surname!,
          imageUrl: user.imageUrl);
    }
  }

  Future<List<Order>> getOrderList({required int userId}) async {
    List<Order> list = [];
    final listFromApi = await _storeApi.fetchOrderList(userID: userId);
    for (DatumOrder o in listFromApi) {
      if (o.id == null ||
          o.date == null ||
          o.number == null ||
          o.productList == null ||
          o.totalCost == null) {
        continue;
      }
      Order order = Order(
          id: o.id!,
          number: o.number!,
          totalCost: o.totalCost!,
          date: o.date!,
          productList: fromListToList(listFromApi: o.productList!));
      list.add(order);
    }
    return list;
  }

  List<Product> fromListToList({required List<DatumProduct> listFromApi}) {
    List<Product> list = [];
    for (DatumProduct p in listFromApi) {
      if (p.id == null ||
          p.name == null ||
          p.price == null ||
          p.rating == null ||
          p.productGroupId == null) {
        continue;
      }
      Product product = Product(
          id: p.id!,
          name: p.name!,
          price: p.price!,
          productGroupId: p.productGroupId!,
          rating: p.rating!,
          imageUrl: p.imageUrl);
      list.add(product);
    }
    return list;
  }
}

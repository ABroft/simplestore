import 'package:simple_store/repository/store_repository.dart' as rep;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_store/models/user.dart';
import 'package:simple_store/models/order.dart';
import 'package:simple_store/models/product.dart';
import 'package:simple_store/models/product_group.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._storeRepository) : super(const StoreState());

  final rep.StoreRepository _storeRepository;

  Future<bool> checkConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(state.copyWith(isConnected: false));
      return false;
    } else {
      emit(state.copyWith(isConnected: true));
      return true;
    }
  }

  Future<void> fetchProductGroupList() async {
    try {
      var isConnected = await checkConnect();
      if (!isConnected) {
        return;
      }
     
      emit(state.copyWith(
          loadStatus: LoadStatus.loading,
          isLocalRep: _storeRepository.isLocalRep));
       
      List<ProductGroup> productGroupList = [];
      var list = await _storeRepository.getProductGroupList();
      for (var g in list) {
        ProductGroup group = ProductGroup(
            id: g.id,
            name: g.name,
            amount: g.amount,
            imageUrl: g.imageUrl ?? 'assets/vegetables.png');
        productGroupList.add(group);
        emit(state.copyWith(
            loadStatus: LoadStatus.success,
            productGroupList: productGroupList));
      }
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<void> fetchGroupList({required ProductGroup group}) async {
    try {
      var isConnected = await checkConnect();
      if (!isConnected) {
        return;
      }
      emit(state.copyWith(
        loadStatus: LoadStatus.loading,
      ));

      var list = await _storeRepository.getGroup(groupid: group.id);

      emit(state.copyWith(
          loadStatus: LoadStatus.success,
          currentGroupList: listToList(listFromApi: list),
          currentGroup: group));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  void addToPreorderList({required Product product}) {
    if (state.preorderList.indexWhere((e) => e.id == product.id) != -1) {
      return;
    } else {
      List<Product> preorderList = List.from(state.preorderList);
      preorderList.add(product);
      emit(state.copyWith(preorderList: preorderList));

    }
  }

  void removeFromPreorderList({required Product product}) {
    if (state.preorderList.indexWhere((e) => e.id == product.id) == -1) {
      return;
    } else {
      List<Product> preorderList = List.from(state.preorderList);
      preorderList.removeWhere((e) => e.id == product.id);
      emit(state.copyWith(preorderList: preorderList));
    }
  }

  Future<void> fetchUserDetails({required int userId}) async {
    try {
      emit(state.copyWith(
        loadStatus: LoadStatus.loading,
      ));
      var userFromApi = await _storeRepository.getUserDetails(userId: userId);
      var orderListFromApi =
          await _storeRepository.getOrderList(userId: userId);

      if (userFromApi == null) {
        throw Exception("invalid user data");
      } else {
        User user = User(
            id: userFromApi.id,
            name: userFromApi.name,
            surname: userFromApi.surname,
            imageUrl: userFromApi.imageUrl);
        List<Order> orderList = [];
        for (var o in orderListFromApi) {
          Order order = Order(
              id: o.id,
              number: o.number,
              totalCost: o.totalCost,
              date: o.date,
              productList: listToList(listFromApi: o.productList));
          orderList.add(order);
        }
        emit(state.copyWith(
            loadStatus: LoadStatus.success, user: user, orderList: orderList));
      }
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  List<Product> listToList({required List listFromApi}) {
    List<Product> productList = [];
    for (var p in listFromApi) {
      Product product = Product(
          id: p.id,
          name: p.name,
          price: p.price,
          rating: p.rating,
          productGroupId: p.productGroupId,
          imageUrl: p.imageUrl ?? 'assets/tea.png');
      productList.add(product);
    }
    return productList;
  }

  Future addToOrderList() async {
    if (state.preorderList.isEmpty){
      return;
    }
    List<Order> orderList = List.from(state.orderList);
    double sum = 0;
    for (var e in state.preorderList) {
      sum += e.price;
    }
    Order newOrder = Order(
        id: orderList.length,
        number: orderList.length.toString(),
        totalCost: sum,
        date: DateTime.now(),
        productList: state.preorderList);
    orderList.add(newOrder);
    // await _storeRepository.addToOrderList(orderList);
    emit(state.copyWith(preorderList: [], orderList: orderList));
  }
}

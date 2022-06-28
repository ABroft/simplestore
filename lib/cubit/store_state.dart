part of 'store_cubit.dart';

enum LoadStatus {
  initial,
  loading,
  success,
  failure,
}

extension LoadStatusG on LoadStatus {
  bool get isInitial => this == LoadStatus.initial;
  bool get isLoading => this == LoadStatus.loading;
  bool get isSucces => this == LoadStatus.success;
  bool get isFailure => this == LoadStatus.failure;
}

class StoreState extends Equatable {
  const StoreState({
    this.isLocalRep = false,
    this.loadStatus = LoadStatus.initial,
    this.isConnected = true,
    this.user,
    this.orderList = const [],
    this.currentGroup,
    this.productGroupList = const [],
    this.currentGroupList = const [],
    this.preorderList = const [],
  });
  final bool isLocalRep;
  final LoadStatus loadStatus;
  final bool isConnected;
  final User? user;
  final List<Order> orderList;
  final  ProductGroup? currentGroup;
  final List<ProductGroup> productGroupList;
  final List<Product> currentGroupList;
  final List<Product> preorderList;

  StoreState copyWith({
    bool? isLocalRep,
    LoadStatus? loadStatus,
    bool? isConnected,
    User? user,
    List<Order>? orderList,
    List<ProductGroup>? productGroupList,
    ProductGroup? currentGroup, 
    List<Product>? currentGroupList,
    List<Product>? preorderList,
  }) {
    return StoreState(
      isLocalRep: isLocalRep ?? this.isLocalRep,
        loadStatus: loadStatus ?? this.loadStatus,
        isConnected: isConnected ?? this.isConnected,
        user: user ?? this.user,
        orderList: orderList ?? this.orderList,
        currentGroup: currentGroup ?? this.currentGroup,
        productGroupList: productGroupList ?? this.productGroupList,
        currentGroupList: currentGroupList ?? this.currentGroupList,
        preorderList: preorderList ?? this.preorderList);
  }

  @override
  List<Object?> get props => [loadStatus, isConnected, preorderList, orderList, isLocalRep, user, currentGroup, productGroupList, currentGroupList ];
}

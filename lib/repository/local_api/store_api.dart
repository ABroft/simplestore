
import 'package:simple_store/repository/local_api/models/order.dart';
import 'package:simple_store/repository/local_api/models/product.dart';
import 'package:simple_store/repository/local_api/models/product_group.dart';
import 'package:simple_store/repository/local_api/models/user.dart';



class StoreApi {

  Future<List<DatumProductGroup>> fetchProductGroupList() async {

    await Future.delayed(const Duration(milliseconds: 400));
 
    DatumProductGroup vegetables =DatumProductGroup(
      id: 1,
      name: "Овощи",
      amount: 80,
      imageUrl: "assets/vegetables.png"
      
    );
     DatumProductGroup milk =DatumProductGroup(
      id: 2,
      name: "Молочка",
      amount: 120,
    );

    DatumProductGroup grocery =DatumProductGroup(
      id: 2,
      name: "Бакалея",
      amount: 50,
    );

    DatumProductGroup snacks =DatumProductGroup(
      id: 2,
      name: "Снеки",
      amount: 170,
    );

    return [vegetables, milk, grocery, snacks, vegetables, milk, snacks, grocery, grocery];
  }

  Future<List<DatumProduct>> fetchGroup({required int groupid}) async{
    await  Future.delayed(const Duration(milliseconds: 400));
     
     return [tea, sugar, coffee, ];
  }

  Future<DatumUser> fetchUserDetail({required int userId}) async {
     await  Future.delayed(const Duration(milliseconds: 400));
    return DatumUser(
      id: 1,
      name: "Артемий",
      surname: "Левушкин",
      imageUrl: 'assets/user1.png',
    );
  }

  Future<List<DatumOrder>> fetchOrderList({required int userID}) async {
     await  Future.delayed(const Duration(milliseconds: 400));
     DatumOrder order = DatumOrder(
      id: 1,
      number: "1",
      totalCost: 200,
      date: DateTime(2022, 9, 3, 17, 30 ),
      productList: [ tea, sugar]
     );
     return [order];
  }

  

}

DatumProduct tea = DatumProduct(
      id: 1,
      name: "Чай",
      price: 140,
      productGroupId: 2,
      rating: 4.7,
      imageUrl: 'assets/tea.png'
     );

     DatumProduct sugar = DatumProduct(
      id: 2,
      name: "Сахар",
      price: 60,
      productGroupId: 2,
      rating: 5,
     );
     
     DatumProduct coffee = DatumProduct(
      id: 3,
      name: "Кофе",
      price: 150,
      productGroupId: 2,
      rating: 3.2,
     );
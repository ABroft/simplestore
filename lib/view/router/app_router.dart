import 'package:flutter/material.dart';
import 'package:simple_store/view/authorization.dart';
import 'package:simple_store/view/basket.dart';
import 'package:simple_store/view/catalog.dart';
import 'package:simple_store/view/group.dart';
import 'package:simple_store/view/user_info.dart';


class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Authorization());
      case '/catalog':
        return MaterialPageRoute(builder: (_) => const Catalog());
      case '/group':
        return MaterialPageRoute(builder: (_) => const Group());
      case '/basket':
        return MaterialPageRoute(builder: (_) => const Basket());      
      case '/user':
        return MaterialPageRoute(builder: (_) => const UserInfo());  

      default:
        return MaterialPageRoute(builder: (_) => const Authorization());
    }
  }
}

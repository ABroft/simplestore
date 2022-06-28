import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_store/cubit/store_cubit.dart';

import 'package:simple_store/view/widgets/custom_sc.dart';
import 'package:simple_store/view/widgets/error_page.dart';
import 'package:simple_store/view/widgets/loader.dart';
import 'package:simple_store/view/widgets/product_list.dart';

class Group extends StatelessWidget {
  const Group({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(
          context,
          '/catalog',
        );
        return false;
      },
      child: BlocBuilder<StoreCubit, StoreState>(
        builder: (context, state) {
          return CustomSc(
            title: state.currentGroup?.name ?? "",
            body: Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 0),
              child: (state.loadStatus.isSucces)
                  ? RefreshIndicator(
                      onRefresh: () async {
                        await BlocProvider.of<StoreCubit>(context)
                            .fetchGroupList(
                                group: BlocProvider.of<StoreCubit>(context)
                                    .state
                                    .currentGroup!);
                      },
                      child: ProductList(
                        isABasket: false,
                        list: state.currentGroupList,
                        isLocalRep: state.isLocalRep,
                        preorderList: state.preorderList,
                      ),
                    )
                  : (state.loadStatus.isFailure)
                      ? const ErrorPage()
                      : const Loader(),
            ),
          );
        },
      ),
    );
  }
}

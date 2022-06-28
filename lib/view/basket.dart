import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_store/cubit/store_cubit.dart';
import 'package:simple_store/view/widgets/custom_sc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_store/view/widgets/product_list.dart';

class Basket extends StatelessWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations text = AppLocalizations.of(context)!;
    return CustomSc(
        title: text.wishSwish,
        index: 1,
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
          child:
              BlocBuilder<StoreCubit, StoreState>(builder: ((context, state) {
            double sum = 0;
            for (var e in state.preorderList) {
              sum += e.price;
            }
            bool isNotEmpty = state.preorderList.isNotEmpty;
            return (isNotEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            text.total,
                            style: theme.textTheme.titleLarge,
                          ),
                          Text(
                            '${sum.toInt()} \u20BD',
                            style: theme.textTheme.titleLarge,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                          child: ProductList(
                              list: state.preorderList,
                              isABasket: true,
                              isLocalRep: state.isLocalRep)),
                      SizedBox(
                        height: 88,
                        child: Center(
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            onTap: () {
                              {
                                BlocProvider.of<StoreCubit>(context)
                                    .addToOrderList();
                              }
                            },
                            child: Container(
                              height: 58,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                color: theme.colorScheme.primary,
                              ),
                              child: Center(
                                child: Text(text.pay,
                                    style: theme.textTheme.titleSmall!.copyWith(
                                        color: theme.colorScheme.onPrimary)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      text.emptyBasket,
                      style: theme.textTheme.titleLarge,
                    ),
                  );
          })),
        ));
  }
}

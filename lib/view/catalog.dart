import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_store/cubit/store_cubit.dart';
import 'package:simple_store/models/product_group.dart';
import 'package:simple_store/view/widgets/custom_sc.dart';
import 'package:simple_store/view/widgets/error_page.dart';
import 'package:simple_store/view/widgets/loader.dart';
import 'package:simple_store/view/widgets/picture.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Catalog extends StatelessWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSc(
        index: 0,
        title: AppLocalizations.of(context)!.wishSwish,
        body: const CatalogBody());
  }
}

class CatalogBody extends StatelessWidget {
  const CatalogBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations text = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              text.catalog,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 32,
            ),
            Expanded(child: BlocBuilder<StoreCubit, StoreState>(
              builder: (context, state) {
                if (state.loadStatus.isSucces) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await BlocProvider.of<StoreCubit>(context)
                          .fetchProductGroupList();
                    },
                    child: GridView.builder(
                      itemCount: state.productGroupList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / 375,
                      ),
                      itemBuilder: (context, index) {
                        ProductGroup item = state.productGroupList[index];
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<StoreCubit>(context).fetchGroupList(group: item);
                            Navigator.pushNamed(context, '/group');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 32, color: theme.shadowColor)
                                ]),
                            padding: const EdgeInsets.all(8),
                            height: 157,
                            width: 157,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Picture(
                                  url: item.imageUrl,
                                  radius: 8,
                                  isLocalRep: state.isLocalRep,
                                  width: 142,
                                  height: 114,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      item.name,
                                      style: theme.textTheme.titleMedium,
                                      maxLines: 1,
                                    )),
                                    Text('${item.amount} шт.',
                                        style: theme.textTheme.titleSmall),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                if (state.loadStatus.isFailure) {
                  return const ErrorPage();
                } else {
                  return const Loader();
                }
              },
            ))
          ],
        ));
  }
}

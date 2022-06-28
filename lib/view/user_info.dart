import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_store/cubit/store_cubit.dart';
import 'package:simple_store/models/order.dart';
import 'package:simple_store/view/widgets/bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations text = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: const BottomBar(index: 2),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<StoreCubit, StoreState>(
            builder: (context, state) {
              List<Widget> list = List.generate(state.orderList.length,
                  ((index) => Bill(order: state.orderList[index])));
              list.insert(
                  0,
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (state.user!.imageUrl == null)
                            ? ClipOval(
                                child: Container(
                                height: 84,
                                width: 84,
                                color: Theme.of(context).colorScheme.primary,
                              ))
                            : (state.isLocalRep)
                                ? Image.asset(
                                    state.user!.imageUrl!,
                                    height: 84,
                                    width: 84,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: state.user!.imageUrl!,
                                    height: 84,
                                    width: 84,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator()),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user!.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              state.user!.surname,
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ],
                        )
                      ],
                    ),
                  ));
              list.insert(
                1,
                const SizedBox(
                  height: 20,
                ),
              );
              list.insert(
                2,
                Text(
                  text.history,
                  style: theme.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              );
              list.insert(
                  3,
                  const SizedBox(
                    height: 16,
                  ));

              return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: list);
            },
          ),
        ),
      ),
    ));
  }
}

class Bill extends StatelessWidget {
  const Bill({Key? key, required this.order}) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    AppLocalizations text = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);
    List<Widget> list = List.generate(
        order.productList.length,
        ((index) => BillRow(
            name: order.productList[index].name,
            price: order.productList[index].price)));
    list.insert(
        0,
        Container(
          padding: const EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${text.orderNumber} №${order.number}',
                style: theme.textTheme.titleMedium,
              ),
              Container(
                height: 36,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: theme.hoverColor)),
                child: Text(
                  '${order.totalCost.toInt()} \u20BD',
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ));
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }
}

class BillRow extends StatelessWidget {
  const BillRow({Key? key, required this.name, required this.price})
      : super(key: key);
  final String name;
  final double price;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: theme.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.normal),
          ),
          Text(
            '${price.toInt()}\u20BD',
            style: theme.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

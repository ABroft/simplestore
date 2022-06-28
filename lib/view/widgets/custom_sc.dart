import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_store/cubit/store_cubit.dart';
import 'package:simple_store/view/widgets/bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomSc extends StatelessWidget {
  const CustomSc({Key? key,  this.index, required this.title, required this.body}) : super(key: key);
  
  final Widget body;
  final String title;
  final int? index;
  @override
  Widget build(BuildContext context) {
    AppLocalizations text = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);
    return  SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 20.0,
        title: BlocSelector<StoreCubit, StoreState, bool>(
          selector: (state) {
            return state.isConnected;
          },
          builder: (context, isConnected) {
            return Text((isConnected) ? title : text.noConnection,
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: theme.colorScheme.onPrimary));
          },
        ),
      ),
      body: body,
      bottomNavigationBar:  (index != null) ? BottomBar(index: index!) : null ,
    ));
  }
}
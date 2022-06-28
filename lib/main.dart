import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_store/cubit/store_cubit.dart';
import 'package:simple_store/repository/store_repository.dart';
import 'package:simple_store/view/authorization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_store/view/router/app_router.dart';
import 'package:simple_store/view/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(SimpleStore());
  });
}

class SimpleStore extends StatelessWidget {
  SimpleStore({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit(StoreRepository())
                  ..fetchProductGroupList(),  
      child: MaterialApp(
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.wishSwish,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        onGenerateRoute: _appRouter.onGenerateRoute,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru', ''),
        ],
        home: const Authorization(),
      ),
    );
  }
}

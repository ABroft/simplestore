import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_store/cubit/store_cubit.dart';

class Authorization extends StatelessWidget {
  const Authorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Logo(),
              LogIn(),
            ],
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 122,
        ),
        const SizedBox(
          height: 24,
        ),
        Text(AppLocalizations.of(context)!.logoTitle, style: Theme.of(context).textTheme.titleLarge,),
      ],
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppLocalizations text = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.authorization, style: theme.textTheme.titleMedium,),
          const SizedBox(
            height: 24,
          ),
          Column(
            children: [
              TextFF(hintText: text.emailHint, isEmail: true),
              const SizedBox(
                height: 16,
              ),
              TextFF(hintText: text.paroleHint, isEmail: false),
              const SizedBox(
                height: 32,
              ),
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<StoreCubit>(context).fetchUserDetails(userId:1);
                    Navigator.pushReplacementNamed(context, '/catalog');
                  }
                },
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: theme.colorScheme.primary,
                  ),
                  child: Center(
                    child: Text(
                      text.enter,
                      style:  theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.onPrimary)),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextFF extends StatelessWidget {
  const TextFF({Key? key, required this.hintText, required this.isEmail})
      : super(key: key);
  final bool isEmail;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    AppLocalizations text = AppLocalizations.of(context)!;

    String? validateEmail(String? value) {
      String pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      RegExp regex = RegExp(pattern);
      if (value == null || value.isEmpty || !regex.hasMatch(value)) {
        return text.validateEmail;
      } else {
        return null;
      }
    }

    String? validateParole(String? value) {
      if (value == null || value.isEmpty) {
        return text.validateParole;
      }
      return null;
    }

    late Function validate;
    if (isEmail) {
      validate = validateEmail;
    } else {
      validate = validateParole;
    }
    return TextFormField(
      obscureText: !isEmail,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      validator: (value) => validate(value),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.index}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BottomAppBar(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        IconButton(
            onPressed: () {
              if (index != 0) Navigator.pushReplacementNamed(context, '/catalog');
            },
            icon: SvgPicture.asset(
              'assets/home.svg',
              width: 24,
              height: 24,
              color: (index == 0) ? theme.colorScheme.primary : null,
            )),
        IconButton(
            onPressed: () {
              if (index != 1) Navigator.pushReplacementNamed(context, '/basket');
            },
            icon: SvgPicture.asset('assets/shopping-bag.svg',
                width: 24,
                height: 24,
                color: (index == 1) ? theme.colorScheme.primary : null)),
        IconButton(
            onPressed: () {
               if (index != 2) Navigator.pushReplacementNamed(context, '/user');
            },
            icon: SvgPicture.asset('assets/user.svg',
                width: 24,
                height: 24,
                color: (index == 2) ? theme.colorScheme.primary : null)),
      ]),
    );
  }
}

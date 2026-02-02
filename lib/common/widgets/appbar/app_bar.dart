import 'package:flutter/material.dart';
import 'package:flutter_two/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSize {
  final Widget? title;
  final Widget? action;
  final bool hideBack;

  const BasicAppBar({
    super.key,
    this.title,
    this.hideBack = false,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: title ?? Text(""),
      actions: [
        action?? Container( )
      ],
      centerTitle: true,
      elevation: 0,
      leading: hideBack
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withAlpha(10)
                      : Colors.black.withAlpha(10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

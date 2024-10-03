import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/constant/app_text_style.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;

  const ReusableAppBar({
    Key? key,
    this.title = "Default Title",
    this.centerTitle = true,
    this.actions,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.white),
      backgroundColor: AppColors.customColor,
      title: Text(title, style: AppTextStyles.heading4),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

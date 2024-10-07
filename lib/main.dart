import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/routes/app_generated_route.dart';
import 'package:hamro_smart_life/view_model/compound_interest_notifier.dart';
import 'package:hamro_smart_life/view_model/main_screen_notifier.dart';
import 'package:hamro_smart_life/view_model/quiz_notifier.dart';
import 'package:hamro_smart_life/view_model/simple_interest_notifier.dart';
import 'package:hamro_smart_life/view_model/todo_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';

void main() async {
  NepaliUtils(Language.nepali);
  await Hive.initFlutter();
  await Hive.openBox('Todo_box');
  runApp(const HamroSmartLife());
}
class HamroSmartLife extends StatelessWidget {
  const HamroSmartLife({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (context) => SimpleInterestNotifier()),
        ChangeNotifierProvider(create: (context) => CompoundInterestNotifier()),
        ChangeNotifierProvider(create: (context) => QuizNotifier()),
        ChangeNotifierProvider(create: (context) => TodoNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: AppColors.customColor),
        initialRoute: '/main_screen',
        onGenerateRoute: AppRoutes.onGeneratedRoute,
        supportedLocales: const [
          Locale('en', ''),
          Locale('ne', ''),
        ],
        builder: (context, child) {
          return InAppUpdateWrapper(child: child);
        },
      ),
    );
  }
}

class InAppUpdateWrapper extends StatefulWidget {
  final Widget? child;

  const InAppUpdateWrapper({Key? key, this.child}) : super(key: key);

  @override
  State<InAppUpdateWrapper> createState() => _InAppUpdateWrapperState();
}

class _InAppUpdateWrapperState extends State<InAppUpdateWrapper> {
  @override
  void initState() {
    super.initState();
    _checkForUpdate();
  }

  void _checkForUpdate() async {
    try {
      var updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      } else {
        log("No update available.");
      }
    } catch (e) {
      log("In-App Update Error: $e");
      // Optionally, show a message to the user about the failed update
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }
}

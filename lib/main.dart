import 'package:dos/common/intro_page.dart';
import 'package:dos/common/widgets/splash.dart';
import 'package:dos/db/db_helper.dart';
import 'package:dos/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

//import 'common/add_task_bar.dart';
import 'common/menu.dart';
import 'common/theme.dart';
//import 'controllers/task_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meselal',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      home: const Splash(
          //title: 'Meselal',
          ),
    );
  }
}

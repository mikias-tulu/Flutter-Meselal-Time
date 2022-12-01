import 'package:dos/common/add_task_bar.dart';
import 'package:dos/common/pages/logs.dart';
import 'package:dos/common/pages/progress.dart';
import 'package:dos/common/theme.dart';
import 'package:dos/controllers/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:dos/common/home_page.dart';
import 'package:get/get.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        HomePage(),
        const Logs(),
        const ProgressPage(),
      ][currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(() => const AddTaskPage());
          Get.put(TaskController()).getTasks();
        },
        backgroundColor: bluishClr,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Colors.white,
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: 0.5,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ), //border radius doesn't work when the notch is enabled.
        elevation: 10,
        tilesPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),

        items: const <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: bluishClr,
            icon: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            title: Text(
              "Home",
              style: TextStyle(color: const Color(0xFFFFFFFF)),
            ),
          ),
          BubbleBottomBarItem(
              backgroundColor: bluishClr,
              icon: Icon(
                Icons.history,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.history,
                color: Colors.white,
              ),
              title: Text(
                "Logs",
                style: TextStyle(color: const Color(0xFFFFFFFF)),
              )),
          BubbleBottomBarItem(
              backgroundColor: bluishClr,
              icon: Icon(
                Icons.auto_graph,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.auto_graph,
                color: Colors.white,
              ),
              title: Text(
                "Progress",
                style: TextStyle(color: const Color(0xFFFFFFFF)),
              )),
        ],
      ),
    );
  }
}

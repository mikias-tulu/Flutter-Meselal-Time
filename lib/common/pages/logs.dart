import 'package:dos/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../widgets/task_tile.dart';

class Logs extends StatefulWidget {
  const Logs({super.key});

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  final _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recent Logs'),
        titleTextStyle: subHeadingStyle.copyWith(color: Colors.grey[600]),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage(
              "Assets/images/profile.png",
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Completed Tasks",
                      style: subHeadingStyle,
                    ),
                  ),
                ]),
                const Divider(
                  color: Colors.black,
                  indent: 20,
                  endIndent: 120,
                ),
                const SizedBox(
                  height: 10,
                ),
                _showTasks(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              print(task.toJson());
              if (task.isCompleted == 1) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // task is _taskController.taskList[index]
                          },
                          child: TaskTile(task),
                        ),
                      ],
                    ),
                  )),
                );
              } else {
                return Container();
              }
            });
      }),
    );
  }
}

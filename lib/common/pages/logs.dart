import 'package:dos/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../widgets/task_tile.dart';

class Logs extends StatefulWidget {
  final Task? task;
  const Logs({super.key, this.task});

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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //ovedue tasks display
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
                            "OverDue Tasks",
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
                      _showOverdueTasks(),

                      //end to overdue
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

                      _showTasks(),
                    ],
                  ),
                ),
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

  _showOverdueTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];

              String dt1 = DateFormat.yMd().format(DateTime.now());
              if (task.date!.compareTo(dt1) < 0 && task.isCompleted == 0) {
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

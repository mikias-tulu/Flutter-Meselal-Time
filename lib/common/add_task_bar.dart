import 'package:dos/common/theme.dart';
import 'package:dos/common/widgets/button.dart';
import 'package:dos/common/widgets/input_field.dart';
import 'package:dos/controllers/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  //int _selectedRemind = 5;
  /* List<int> remindList = [
    5,
    10,
    15,
    20,
  ]; */

  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
  ];

  int _selectedColor = 0;
  bool isSwitched = false;
  bool isAlarm = false;
  String _alarmValue = "9:30 PM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              MyInputField(
                title: "Title",
                hint: "Enter your title",
                controller: _titleController,
              ),
              MyInputField(
                title: "Note",
                hint: "Enter your note",
                controller: _noteController,
              ),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _getDateFromUser();
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              /* MyInputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  onChanged: (String? newvalue) {
                    setState(() {
                      _selectedRemind = int.parse(newvalue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ), */

              /* MyInputField(
                title: "Repeat",
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  onChanged: (String? newvalue) {
                    setState(() {
                      _selectedRepeat = newvalue!;
                    });
                  },
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!,
                          style: const TextStyle(color: Colors.grey)),
                    );
                  }).toList(),
                ),
              ), */
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Text(
                    'Repeat Daily',
                    style: titleStyle,
                  ),
                  Transform.scale(
                    scale: 1.32,
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          if (value == true) {
                            _selectedRepeat = 'Daily';
                          } else {
                            _selectedRepeat = 'None';
                          }
                          print(_selectedRepeat);
                        });
                      },
                      activeTrackColor: Colors.lightBlue,
                      activeColor: const Color.fromARGB(255, 9, 108, 189),
                    ),
                  ),
                  Text(
                    'Alarm',
                    style: titleStyle,
                  ),
                  Transform.scale(
                    scale: 1.32,
                    child: Switch(
                      value: isAlarm,
                      onChanged: (value) {
                        setState(() {
                          isAlarm = value;
                          if (value == true) {
                            //_alarmValue = _getAlarmvalue();
                            print('alarm');
                            _alarmValue = _getAlarmvalue().toString();
                          } else {
                            print('no');
                            _alarmValue = " ";
                          }
                          //print(_getAlarmvalue());
                        });
                      },
                      activeTrackColor: Colors.lightBlue,
                      activeColor: const Color.fromARGB(255, 9, 108, 189),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(label: "Create Task", onTab: () => _validateData())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_titleController
        .text.isNotEmpty /*&& _noteController.text.isNotEmpty */) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController
        .text.isEmpty /*|| _noteController.text.isEmail*/) {
      Get.snackbar(
        "Required",
        "Title is required !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: const Icon(Icons.warning_amber_rounded),
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        //remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
        //alarmTime: _alarmValue,
      ),
    );
    print("New id " + "$value");
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
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
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2121),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("it's null or something is wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time cancelled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _getAlarmvalue() {
    DateTime date = DateFormat.jm().parse(_startTime.toString());
    var myTime = DateFormat("HH:mm").format(date);
    var alarmhour = int.parse(myTime.toString().split(":")[0]);
    var alarmminute = int.parse(myTime.toString().split(":")[1]);
    FlutterAlarmClock.createAlarm(alarmhour, alarmminute);
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tag",
          style: titleStyle,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? bluefaded
                        : index == 1
                            ? pinkClr
                            : yellowClr,
                    child: _selectedColor == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

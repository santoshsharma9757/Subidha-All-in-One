import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/constant/app_text_style.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoNotifier extends ChangeNotifier {
  List<Map<String, dynamic>> todos = [];
  var todoBox = Hive.box('Todo_box');
  //create task
  createData(Map<String, dynamic> data) {
    todoBox.add(data);
    log("todo box ${todoBox.length}");
    readData();
  }

//read task
  readData() async {
    var data = await todoBox.keys.map((key) {
      final item = todoBox.get(key);
      return {'key': key, 'title': item['title'], "task": item['task']};
    }).toList();
    todos = data.reversed.toList();
    notifyListeners();
  }

  //updata task
  updateData(int key, Map<String, dynamic> data) {
    todoBox.put(key, data);
    readData();
  }

  //Delete
  deleteData(int key) {
    todoBox.delete(key);
    readData();
  }

  var titleController = TextEditingController();
  var taskController = TextEditingController();

  showAddTodoBottomSheet(BuildContext context, int? key) {
    titleController.clear();
    taskController.clear();
    if (key != null) {
      final itemData = todos.firstWhere((element) => element['key'] == key);
      titleController.text = itemData['title'];
      taskController.text = itemData['task'];
    }
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              12, 12, 12, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Task',
                style: AppTextStyles.heading5,
              ),
              AppSpacing.verticalMedium,
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'Enter your title',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColors.primary.withOpacity(0.1)),
              ),
              AppSpacing.verticalMedium,
              TextField(
                controller: taskController,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: 'Enter your task',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColors.primary.withOpacity(0.1)),
              ),
              AppSpacing.verticalMedium,
              GestureDetector(
                onTap: () {
                  var dataToStore = {
                    'title': titleController.text.toString(),
                    'task': taskController.text.toString()
                  };

                  if (key == null) {
                    createData(dataToStore);
                  } else {
                    updateData(key, dataToStore);
                  }

                  Navigator.of(context).pop();
                },
                child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          key == null ? 'CREATE TASK' : 'UPDATE TASK',
                          style: AppTextStyles.heading4,
                        ),
                      ),
                    )),
              ),
              AppSpacing.verticalMedium,
            ],
          ),
        );
      },
    );
  }
}

import 'dart:math';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/constant/app_text_style.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_appbar.dart';
import 'package:hamro_smart_life/view_model/todo_notifier.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoNotifier provider;
  @override
  void initState() {
    provider = Provider.of<TodoNotifier>(context, listen: false);
    provider.readData();
    super.initState();
  }

  Color generateRandomColorWithOpacity() {
    final random = Random();
    Color baseColor = Colors.primaries[random.nextInt(Colors.primaries.length)];
    return baseColor.withOpacity(0.5); // Random opacity between 0.0 and 1.0
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoNotifier>(
      builder: (context, value, child) => Scaffold(
        appBar: const ReusableAppBar(
          title: "Task",
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: value.todos.length,
          itemBuilder: (context, index) {
            var currentData = value.todos[index];
            return Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.medium,
                  right: AppPadding.medium,
                  top: AppPadding.medium),
              child: ExpansionTileCard(
                baseColor: generateRandomColorWithOpacity(),
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(
                  currentData['title'],
                  style: AppTextStyles.heading5,
                ),
                subtitle: Text(
                  currentData['task'],
                  maxLines: 1,
                ),
                children: <Widget>[
                  const Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${currentData['task']}",
                        style: AppTextStyles.heading5),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          provider.showAddTodoBottomSheet(
                              context, currentData['key']);
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.edit),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          provider.deleteData(currentData['key']);
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text('Share'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            provider.showAddTodoBottomSheet(context, null);
          },
          tooltip: 'Add Todo',
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

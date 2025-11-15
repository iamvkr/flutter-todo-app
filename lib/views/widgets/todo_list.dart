import 'package:flutter/material.dart';
import 'package:todo_app/data/notifiers.dart';
import 'package:todo_app/prefs_service.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.onDelete});
  final void Function(int index) onDelete;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todoListNotifier,
      builder: (context, todoListValue, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: todoListValue.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  todoListValue.elementAt(index).title,
                  style: TextStyle(
                    decoration:
                        todoListValue.elementAt(index).checked
                            ? TextDecoration.lineThrough
                            : null,
                  ),
                ),
                leading: Checkbox(
                  value: todoListValue.elementAt(index).checked,
                  onChanged: (value) {
                    if (value != null) {
                      // 1. update checked
                      todoListValue[index].checked = value;
                      // 2. Force the notifier to update by creating a new list
                      //    This tells ValueListenableBuilder to rebuild
                      todoListNotifier.value = List.from(todoListValue);
                      // 3. Save the change!
                      saveTodos(todoListNotifier.value);
                      // setState(() {
                      //   todoListValue[index].checked = value;
                      // });
                    }
                  },
                ),
                trailing: IconButton(
                  onPressed: () {
                    widget.onDelete(index);
                  },
                  icon: Icon(Icons.close),
                ),
                onTap: () {},
              );
            },
          ),
        );
      },
    );
  }
}

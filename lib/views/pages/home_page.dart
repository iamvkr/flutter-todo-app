
import 'package:flutter/material.dart';
import 'package:todo_app/data/notifiers.dart';
import 'package:todo_app/prefs_service.dart';
import 'package:todo_app/views/widgets/todo_list.dart';
import 'package:todo_app/models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Todo> todoList = todoListNotifier.value;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int generateTodoId() {
      return DateTime.now().millisecondsSinceEpoch;
    }

    // void handleSetSharedPref() async {
    //   //  Convert your List<Todo> to a List<Map>
    //   List<Map<String, dynamic>> listMap =
    //       todoList.map((todo) => todo.toMap()).toList();
    //   String jsonString = json.encode(listMap);

    //   //  Save the string to SharedPreferences
    //   await asyncPrefs.setString('myTodos', jsonString);
    //   print('todo saved!');
    // }

    void handleAddTodo() {
      if (controller.text.isNotEmpty) {
        setState(() {
          todoListNotifier.value.add(
            Todo(id: generateTodoId(), title: controller.text, checked: false),
          );
          controller.clear();
          // save to sharedPref:
          saveTodos(todoListNotifier.value);
        });
      }
    }

    void handleDeleteTodo(int index) {
      setState(() {
        todoListNotifier.value.removeAt(index);
        saveTodos(todoListNotifier.value);
      });
    }

    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter your Todo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10, height: 5),
              FilledButton(onPressed: handleAddTodo, child: Text('ADD')),
            ],
          ),
          TodoList(onDelete: handleDeleteTodo),
        ],
      ),
    );
  }
}

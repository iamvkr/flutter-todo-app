import 'package:flutter/widgets.dart';
import 'package:todo_app/models/todo_model.dart';

List<Todo> todoList = [
  // Todo(id: 1, title: "title", checked: true)
];

ValueNotifier<List<Todo>> todoListNotifier = ValueNotifier(
  todoList,
);
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);
ValueNotifier<int> navIndexNotifier = ValueNotifier(0);

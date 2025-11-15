import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/todo_model.dart';

final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

// ADD THIS FUNCTION:
Future<void> saveTodos(List<Todo> todos) async {
  List<Map<String, dynamic>> listMap = todos.map((todo) => todo.toMap()).toList();
  String jsonString = json.encode(listMap);
  await asyncPrefs.setString('myTodos', jsonString);
  print('Todos saved!');
}
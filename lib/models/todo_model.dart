// lib/models/todo_model.dart
class Todo {
  final int id;
  final String title;
  bool checked;

  Todo({required this.id, required this.title, required this.checked});

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      title: map['title'] as String,
      checked: map['checked'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'checked': checked};
  }
}
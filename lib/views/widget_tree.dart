import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/data/notifiers.dart';
import 'package:todo_app/prefs_service.dart';
import 'package:todo_app/views/pages/home_page.dart';
import 'package:todo_app/views/pages/settings_page.dart';
import 'package:todo_app/views/widgets/BottomNavbar.dart';
// import 'package:todo_app/views/widgets/todo_list.dart';
import 'package:todo_app/models/todo_model.dart';

List<Widget> pages = [HomePage(), SettingsPage()];

class WidgetTreee extends StatefulWidget {
  const WidgetTreee({super.key});

  @override
  State<WidgetTreee> createState() => _WidgetTreeeState();
}

class _WidgetTreeeState extends State<WidgetTreee> {
  @override
  void initState() {
    void initMode() async {
      // dark mode pref:
      var isDark = await asyncPrefs.getBool('isDarkMode');
      var todoString = await asyncPrefs.getString('myTodos');
      print(todoString);
      List<Todo> loadedTodos = [];
      if (todoString != null && todoString.isNotEmpty) {
        print("inside if:");
        print(todoString);
        // Decode the string back into a List json.decode turns it into a List<dynamic>
        var decodedList = json.decode(todoString) as List<dynamic>;

        // 4. Map that list of Maps into a List of Todos
        //    (This is the reverse of what you did to save)
        loadedTodos =
            decodedList.map((map) {
              // For each 'map' in the list, create a Todo object
              return Todo.fromMap(map as Map<String, dynamic>);
            }).toList(); // Convert it to a List<Todo>
      }
      setState(() {
        isDarkModeNotifier.value = isDark ?? false;
        todoListNotifier.value = loadedTodos;
      });
    }

    initMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: navIndexNotifier,
      builder: (context, index, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            if (navIndexNotifier.value != 0) {
              setState(() {
                navIndexNotifier.value = 0;
              });
              return;
            }
            final shouldExit = await showDialog<bool>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Exit App'),

                    content: SizedBox(
                      width:
                          MediaQuery.of(context).size.width *
                          0.9, // 90% of screen width
                      child: const Text('Are you sure you want to exit?'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Exit'),
                      ),
                    ],
                  ),
            );

            if (shouldExit == true) {
              // Close the app programmatically
              SystemNavigator.pop();
              // Navigator.of(context).maybePop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              toolbarHeight: 70,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
              title: Text('Todo App'),
              actions: [
                IconButton(
                  onPressed: () async {
                    setState(() {
                      isDarkModeNotifier.value = !isDarkModeNotifier.value;
                    });
                    await asyncPrefs.setBool(
                      'isDarkMode',
                      isDarkModeNotifier.value,
                    );
                    print('curretly: isDarkModeNotifier is:');
                    print(isDarkModeNotifier.value);
                  },
                  icon: Icon(
                    isDarkModeNotifier.value
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  color: Colors.white,
                ),
              ],
            ),

            body: pages.elementAt(index),
            bottomNavigationBar: BottomNavbar(),
          ),
        );
      },
    );
  }
}

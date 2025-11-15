import 'package:flutter/material.dart';
import 'package:todo_app/data/notifiers.dart';
import 'package:todo_app/prefs_service.dart';
import 'package:todo_app/views/widget_tree.dart';

void main() async {
  // 2. Ensure Flutter is ready before using async/await
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Load the setting *before* running the app
  var isDark = await asyncPrefs.getBool('isDarkMode');

  // 4. Set the notifier's value. This is the new "default"
  isDarkModeNotifier.value = isDark ?? false;

  // 5. Now run the app. It will build with the correct value.
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (BuildContext context, bool value, Widget? child) {
        return MaterialApp(
          title: 'Todo App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: value ? Brightness.dark : Brightness.light,
            ),
          ),
          home: WidgetTreee(),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Map<String, dynamic>> optionsList = [
    {
      "title": "Share",
      "icon": Icons.share,
      "onClick": (BuildContext context) {
        SharePlus.instance.share(
          ShareParams(text: 'Download this app from https://github.com/iamvkr/flutter-todo-app'),
        );
      },
    },
    {
      "title": "About",
      "icon": Icons.info,
      "onClick": (BuildContext c) {
        showAboutDialog(context: c);
      },
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: optionsList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(optionsList.elementAt(index)["title"]),
          leading: Icon(optionsList.elementAt(index)["icon"]),
          onTap: () => optionsList.elementAt(index)["onClick"](context),
        );
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rickmarty/initialization/initialization.dart';
import 'package:rickmarty/screens/rickmarty.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Initialization.initHive();
  runApp(RickMartyApp());
}

class RickMartyApp extends StatelessWidget {
  const RickMartyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('store').listenable(),
        builder: (context, Box box, _){
          final isTheme = box.get('theme_text', defaultValue: false);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Rick and Marty',
            home: RickMarty(),
            theme: isTheme ? ThemeData.dark() : ThemeData.light(),
          );
        }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:links_social_media/model/links_item.dart';
import 'package:links_social_media/widgets/Condition_check.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Item>(
      create: (BuildContext context) => Item(),
      child: MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        home: Auth(),
      ),
    );
  }
}

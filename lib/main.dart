import 'package:flutter/material.dart';
import 'package:links_social_media/model/links_item.dart';
import 'package:links_social_media/widgets/Condition_check.dart';
import 'package:provider/provider.dart';

import 'ligin/network/Request/Link/get_link.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Item>(create: (BuildContext context) => Item()),
        ChangeNotifierProvider<GetLinks>(create: (context) => GetLinks()),
      ],
      child: MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        home: Auth(),
      ),
    );
  }
}

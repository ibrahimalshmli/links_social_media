import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/network/Request/Link/edit_link.dart';
import 'package:links_social_media/widgets/Condition_check.dart';
import 'package:provider/provider.dart';

import 'ligin/network/Request/Link/get_link.dart';
import 'ligin/network/Request/active_sharing/Active_Sharing.dart';
import 'ligin/network/Request/followers/getfollowing.dart';
import 'ligin/network/Request/followers/postfollowers.dart';
import 'ligin/network/Request/location/location.dart';
import 'ligin/network/Request/search/search.dart';
import 'model/mymodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GetLinks>(create: (context) => GetLinks()),
        ChangeNotifierProvider(create: (_) => EditProvider()),
        ChangeNotifierProvider(create: (_) => FollowApi()),
        ChangeNotifierProvider(create: (_) => FollowersApi()),
        ChangeNotifierProvider(create: (_) => EditLocatino()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ActiveSharingProvider()),
        ChangeNotifierProvider(create: (_) => FetchUser()),
      ],
      child: MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        home: Auth(),
      ),
    );
  }
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

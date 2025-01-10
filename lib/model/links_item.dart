import 'package:flutter/cupertino.dart';
import 'package:links_social_media/model/mymodel.dart';

class Item extends ChangeNotifier {
  List<LinkMymodel> links = [];
  void addlinks(
    TextEditingController titleController,
    TextEditingController linkController,
    TextEditingController usernameController,
  ) {
    links.add(
      LinkMymodel(
        title: titleController.text,
        link: linkController.text,
        username: usernameController.text,
        isActive: 1,
        // isActive: true,
      ),
    );
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:links_social_media/model/mymodel.dart';

class Item extends ChangeNotifier {
  List<LinkModel> links = [];
  void addlinks(
    TextEditingController titleController,
    TextEditingController linkController,
    TextEditingController usernameController,
  ) {
    links.add(
      LinkModel(
        title: titleController.text,
        link: linkController.text,
        username: usernameController.text,
        id: 0,
        // isActive: true,
      ),
    );
    notifyListeners();
  }
}

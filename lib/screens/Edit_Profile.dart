import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/widget/button_widget.dart';
import 'package:links_social_media/ligin/widget/textfiled_widget.dart';

import '../ligin/network/Request/Link/edit_link.dart';
import '../model/mymodel.dart';

class EditScreen extends StatefulWidget {
  final LinkMymodel linkData;

  EditScreen({super.key, required this.linkData});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController titleController;
  late TextEditingController linkController;
  late TextEditingController usernameController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.linkData!.title);
    linkController = TextEditingController(text: widget.linkData!.link);
    usernameController = TextEditingController(text: widget.linkData!.username);
  }

  @override
  void dispose() {
    titleController.dispose();
    linkController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("title", style: TextStyle(fontSize: 20)),
              SizedBox(height: 3),
              customTextField(
                titleController,
                "title",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return value;
                  }
                  return " Enter your title ";
                },
              ),
              SizedBox(height: 10),
              Text("link", style: TextStyle(fontSize: 20)),
              SizedBox(height: 3),
              customTextField(
                linkController,
                "link",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return value;
                  }
                  return " Enter your link ";
                },
              ),
              SizedBox(height: 10),
              Text("usernam", style: TextStyle(fontSize: 20)),
              SizedBox(height: 3),
              customTextField(
                usernameController,
                "usernam",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return value;
                  }
                  return " Enter your usernam ";
                },
              ),
              SizedBox(height: 30),
              Center(
                child: ButtonWidget(
                  text: "ADD",
                  onPressed: () async {
                    await editLink(
                      context: context,
                      title: titleController.text,
                      link: linkController.text,
                      username: usernameController.text,
                      isActive: true,
                    );
                    // Navigator.pop(context);
                  },
                  color: const Color(0xffFFD465),
                  Color: const Color(0xff784E00),
                ),
              ),
              //    Consumer<Link>(builder: )
            ],
          ),
        ),
      ),
    );
  }
}

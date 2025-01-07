import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/network/collaction.dart';
import 'package:links_social_media/ligin/widget/button_widget.dart';
import 'package:links_social_media/ligin/widget/textfiled_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NewLinkScreen extends StatelessWidget {
  NewLinkScreen({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  // bool? isActive;

  Future<void> openUrl(String url, BuildContext context) async {
    final Uri uri = Uri.parse(linkController.text);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('لا يمكن فتح الرابط')));
    }
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
                    Colaction colaction = Colaction();
                    await colaction.AddLink(
                      context: context,
                      title: titleController.text,
                      link: linkController.text,
                      username: usernameController.text,
                      isActive: "1",
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

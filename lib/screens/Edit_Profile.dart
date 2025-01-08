// import 'package:flutter/material.dart';
// import 'package:links_social_media/ligin/network/collaction.dart';
// import 'package:links_social_media/ligin/widget/button_widget.dart';
// import 'package:links_social_media/ligin/widget/textfiled_widget.dart';
//
// class EditScreen extends StatelessWidget {
//   EditScreen({super.key});
//   TextEditingController titleController = TextEditingController();
//   TextEditingController linkController = TextEditingController();
//   TextEditingController usernameController = TextEditingController();
//   // bool? isActive;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("title", style: TextStyle(fontSize: 20)),
//               SizedBox(height: 3),
//               customTextField(
//                 titleController,
//                 "title",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return value;
//                   }
//                   return " Enter your title ";
//                 },
//               ),
//               SizedBox(height: 10),
//               Text("link", style: TextStyle(fontSize: 20)),
//               SizedBox(height: 3),
//               customTextField(
//                 linkController,
//                 "link",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return value;
//                   }
//                   return " Enter your link ";
//                 },
//               ),
//               SizedBox(height: 10),
//               Text("usernam", style: TextStyle(fontSize: 20)),
//               SizedBox(height: 3),
//               customTextField(
//                 usernameController,
//                 "usernam",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return value;
//                   }
//                   return " Enter your usernam ";
//                 },
//               ),
//               SizedBox(height: 30),
//               Center(
//                 child: ButtonWidget(
//                   text: "ADD",
//                   onPressed: () async {
//                     Colaction colaction = Colaction();
//                     await colaction.EditLink(
//                       context: context,
//                       title: titleController.text,
//                       link: linkController.text,
//                       username: usernameController.text,
//                       isActive: "1",
//                     );
//                     // Navigator.pop(context);
//                   },
//                   color: const Color(0xffFFD465),
//                   Color: const Color(0xff784E00),
//                 ),
//               ),
//               //    Consumer<Link>(builder: )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/widget/button_widget.dart';
import 'package:links_social_media/ligin/widget/textfiled_widget.dart';
import 'package:links_social_media/model/mymodel.dart';

import '../ligin/network/Request/Link/edit_link.dart';

class EditScreen extends StatefulWidget {
  final LinkMymodel? linkData;

  EditScreen({super.key, this.linkData});

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
      appBar: AppBar(title: Text('Edit Link')),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title", style: TextStyle(fontSize: 20)),
              SizedBox(height: 3),
              customTextField(
                titleController,
                "Title",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your title";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Text("Link", style: TextStyle(fontSize: 20)),
              SizedBox(height: 3),
              customTextField(
                linkController,
                "Link",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your link";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Text("Username", style: TextStyle(fontSize: 20)),
              SizedBox(height: 3),
              customTextField(
                usernameController,
                "Username",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your username";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Center(
                child: ButtonWidget(
                  text: "Update",
                  onPressed: () async {
                    await EditLink(
                      context: context,
                      title: titleController.text,
                      link: linkController.text,
                      username: usernameController.text,
                      isActive: "1",
                    );
                    Navigator.pop(context);
                  },
                  color: const Color(0xffFFD465),
                  Color: const Color(0xff784E00),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

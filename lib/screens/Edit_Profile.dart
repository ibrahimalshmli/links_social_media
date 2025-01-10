// import 'package:flutter/material.dart';
// import 'package:links_social_media/ligin/widget/button_widget.dart';
// import 'package:links_social_media/ligin/widget/textfiled_widget.dart';
//
// import '../model/mymodel.dart';
//
// class EditScreen extends StatefulWidget {
//   final LinkMymodel linkData;
//
//   EditScreen({super.key, required this.linkData});
//
//   @override
//   State<EditScreen> createState() => _EditScreenState();
// }
//
// class _EditScreenState extends State<EditScreen> {
//   late TextEditingController titleController;
//   late TextEditingController linkController;
//   late TextEditingController usernameController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     titleController = TextEditingController(text: widget.linkData!.title);
//     linkController = TextEditingController(text: widget.linkData!.link);
//     usernameController = TextEditingController(text: widget.linkData!.username);
//   }
//
//   @override
//   void dispose() {
//     titleController.dispose();
//     linkController.dispose();
//     usernameController.dispose();
//     super.dispose();
//   }
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
//                   text: "Edit",
//                   onPressed: () async {
//                     // العودة إلى الشاشة السابقة بعد التحديث
//                     Navigator.pop(context);
//                   },
//                   // onPressed: () async {
//                   //   await editLink(
//                   //     context: context,
//                   //     title: titleController.text,
//                   //     link: linkController.text,
//                   //     username: usernameController.text,
//                   //     isActive: true,
//                   //   );
//                   //Navigator.pop(context);
//                   // onPressed: () {},
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
import 'package:links_social_media/ligin/network/Request/Link/edit_link.dart';
import 'package:links_social_media/ligin/widget/button_widget.dart';
import 'package:links_social_media/ligin/widget/textfiled_widget.dart';
import 'package:links_social_media/screens/Profile_screen.dart';
import 'package:provider/provider.dart';

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

    titleController = TextEditingController(text: widget.linkData.title);
    linkController = TextEditingController(text: widget.linkData.link);
    usernameController = TextEditingController(text: widget.linkData.username);
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
      appBar: AppBar(title: Text("Edit Link")),
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
                validator:
                    (value) =>
                        value?.isEmpty == true ? "Enter your title" : null,
              ),
              SizedBox(height: 10),
              Text("Link", style: TextStyle(fontSize: 20)),
              SizedBox(height: 3),
              customTextField(
                linkController,
                "Link",
                validator:
                    (value) =>
                        value?.isEmpty == true ? "Enter your link" : null,
              ),
              SizedBox(height: 10),
              Text("Username", style: TextStyle(fontSize: 20)),
              SizedBox(height: 3),
              customTextField(
                usernameController,
                "Username",
                validator:
                    (value) =>
                        value?.isEmpty == true ? "Enter your username" : null,
              ),
              SizedBox(height: 30),
              Center(
                child: ButtonWidget(
                  text: "Save Changes",
                  onPressed: () async {
                    await Provider.of<EditProvider>(
                      context,
                      listen: false,
                    ).editLink(
                      id: widget.linkData.id.toString(),
                      title: titleController.text,
                      link: linkController.text,
                      username: usernameController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Link updated successfully!")),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => ProfileScreen()),
                    );
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

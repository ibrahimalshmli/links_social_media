import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ligin/network/Request/Link/get_link.dart';
import '../ligin/network/endpoints.dart';
import '../ligin/network/save_token.dart';
import '../screens/Edit_Profile.dart';

Expanded buildExpanded(GetLinks getLinks, BuildContext context) {
  return Expanded(
    child: RefreshIndicator(
      onRefresh: () async {
        await getLinks.getLink(context);
      },
      child:
          getLinks.linkMymodel.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: getLinks.linkMymodel.length,
                itemBuilder: (context, index) {
                  final Uri url = Uri.parse(
                    "${getLinks.linkMymodel[index].link}",
                  );
                  Future<void> _launchUrl() async {
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 10.0,
                    ),
                    child: Slidable(
                      startActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed:
                                (context) => deletLink(
                                  getLinks.linkMymodel[index].id.toString(),
                                  context,
                                ),
                            backgroundColor: Color(0xffF56C61),
                            borderRadius: BorderRadius.circular(20),
                            icon: Icons.delete,
                          ),
                          SizedBox(width: 15),
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => EditScreen(
                                        linkData: getLinks.linkMymodel[index],
                                      ),
                                ),
                              );
                            },
                            backgroundColor: Color(0xffFFD465),
                            borderRadius: BorderRadius.circular(20),
                            icon: Icons.edit,
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              index % 2 == 0
                                  ? Color(0xffFEE2E7)
                                  : Color(0xffE7E5F1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          title: Text(
                            '${getLinks.linkMymodel[index].title}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            "${getLinks.linkMymodel[index].link}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey,
                            ),
                          ),
                          onTap: () {
                            _launchUrl();
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
    ),
  );
}

Future<void> deletLink(String id, BuildContext context) async {
  try {
    String? token = await SharedPreferencesHelper.getToken();
    print(token);
    print(id);
    final response = await http.delete(
      Uri.parse("${Endpoints.edtlinks}$id"),

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Link deleted successfully!')),
      );

      // تحديث البيانات بعد الحذف
      Provider.of<GetLinks>(context, listen: false).getLink(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete link: ${response.statusCode}'),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error occurred: $e')));
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../ligin/network/endpoints.dart';
import '../ligin/network/save_token.dart';
import '../model/mymodel.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<User> users = [];
  Future<List<User>?> searchUser(String name, BuildContext context) async {
    final String? token = await SharedPreferencesHelper.getToken();
    print(token);
    if (token == null) {
      print("Error: Token not found.");
    }
    try {
      String? token = await SharedPreferencesHelper.getToken();

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Token not found. Please login again.')),
        );
        return [];
      }

      var response = await http.post(
        Uri.parse(Endpoints.search),
        headers: {"Authorization": "Bearer $token"},
        body: {
          "name": "momo", // Corrected to use .text
        },
      );
      if (response.statusCode == 200) {
        print(response.statusCode);

        final responseData = json.decode(response.body);
        print(responseData);
        setState(() {
          users = [];
        });
      } else {
        setState(() {
          users = [];
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No user data found.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Exception: $e')));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // حقل إدخال النص للبحث
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter name',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchUser(_searchController.text, context);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            // عرض نتائج البحث
            Expanded(
              child:
                  users.isEmpty
                      ? Center(child: Text('No results found.'))
                      : ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return ListTile(
                            title: Text(user.name),
                            subtitle: Text(user.email),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

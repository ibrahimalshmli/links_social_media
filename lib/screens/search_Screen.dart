import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ligin/network/Request/followers/postfollowers.dart';
import '../ligin/network/Request/search/search.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Users')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // حقل البحث
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name',
                hintText: 'Enter user name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      // إعادة تعيين نتائج البحث عند مسح النص
                      Provider.of<FetchUser>(context, listen: false).users = [];
                    });
                  },
                ),
              ),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  Provider.of<FetchUser>(
                    context,
                    listen: false,
                  ).searchUser(query, context);
                }
              },
            ),
            const SizedBox(height: 16),

            // عرض قائمة المستخدمين الذين تم العثور عليهم
            Consumer<FetchUser>(
              builder: (context, fetchUserProvider, child) {
                final users = fetchUserProvider.users;
                if (users.isEmpty) {
                  return const Center(child: Text('No users found.'));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ListTile(
                          title: Text(user.name ?? 'No Name'),
                          subtitle: Text(user.email ?? 'No Email'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // عند الضغط على زر متابعة، نقوم بإرسال الطلب
                              Provider.of<FollowersApi>(
                                context,
                                listen: false,
                              ).postFollow(context, user.id.toString());
                            },
                            child: const Text('Follow'),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

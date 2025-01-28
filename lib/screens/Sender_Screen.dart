import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ligin/network/Request/active_sharing/Active_Sharing.dart';
import '../widgets/Navigation_Bar.dart';

class SenderPage extends StatefulWidget {
  @override
  _SenderPageState createState() => _SenderPageState();
}

class _SenderPageState extends State<SenderPage> {
  ActiveSharingProvider? _activeSharingProvider;

  @override
  void initState() {
    super.initState();
    _activeSharingProvider = Provider.of<ActiveSharingProvider>(
      context,
      listen: false,
    );
    _activateSharing();
    _fetchNearestUsers();
  }

  @override
  void dispose() {
    _deactivateSharing();
    super.dispose();
  }

  Future<void> _activateSharing() async {
    final success = await _activeSharingProvider?.setActiveSharing('sender');
    if (success == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('You are now a sender!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to set as sender!')));
    }
  }

  Future<void> _deactivateSharing() async {
    final success = await _activeSharingProvider?.removeActiveSharing();
    if (success == true) {
      print('Sender deactivated successfully');
    } else {
      print('Failed to deactivate sender');
    }
  }

  Future<void> _fetchNearestUsers() async {
    await _activeSharingProvider?.fetchNearestUsers();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActiveSharingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Sender Page')),
      body:
          provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: provider.nearestUsers.length,
                itemBuilder: (context, index) {
                  final user = provider.nearestUsers[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      title: Text(user.user.name),
                      subtitle: Text(' ${user.user.email}'),
                    ),
                  );
                },
              ),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}

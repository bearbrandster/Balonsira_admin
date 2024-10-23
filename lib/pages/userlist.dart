import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  final String status;
  final List<Map<String, String>> users;
  final void Function(String userId, String newStatus) onUpdateUserStatus;
  final Future<void> Function() onRefresh;

  UserListPage(
      {required this.status,
      required this.users,
      required this.onUpdateUserStatus,
      required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    // Filter users based on the passed status
    List<Map<String, String>> filteredUsers =
        users.where((user) => user['status'] == status).toList();

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Container(
        color: const Color.fromARGB(255, 98, 100, 104),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${status[0].toUpperCase()}${status.substring(1)} Accounts',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  var user = filteredUsers[index];
                  return ListTile(
                    title: Text(
                      user['email']!,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: (status == 'approved')
                        ? IconButton(
                            icon: Icon(Icons.block, color: Colors.red),
                            onPressed: () {
                              _showConfirmationDialog(
                                  context, 'block', user['email']!);
                            },
                          )
                        : (status == 'blocked')
                            ? IconButton(
                                icon: Icon(Icons.check, color: Colors.green),
                                onPressed: () {
                                  _showConfirmationDialog(
                                      context, 'approve', user['email']!);
                                },
                              )
                            : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, String action, String userId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Are you sure you want to $action this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the user's status based on the action
                onUpdateUserStatus(
                    userId, action == 'approve' ? 'approved' : 'blocked');
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'User ${action == 'approve' ? 'approved' : 'blocked'} successfully!'),
                  ),
                );
              },
              child: Text(action == 'approve' ? 'Approve' : 'Block'),
            ),
          ],
        );
      },
    );
  }
}

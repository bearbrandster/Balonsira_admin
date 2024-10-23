import 'package:admin/pages/userlist.dart'; // Adjust the import as needed
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  // Simulated list of users
  List<Map<String, String>> users = [
    {'email': 'user1@example.com', 'status': 'pending'},
    {'email': 'user2@example.com', 'status': 'pending'},
    {'email': 'user3@example.com', 'status': 'approved'},
    {'email': 'user4@example.com', 'status': 'blocked'},
    {'email': 'user5@example.com', 'status': 'approved'},
    {'email': 'user6@example.com', 'status': 'blocked'},
  ];

  void _updateUserStatus(String userId, String newStatus) {
    setState(() {
      for (var user in users) {
        if (user['email'] == userId) {
          user['status'] = newStatus;
          // Remove user from the list if they are being approved or blocked
          if (newStatus == 'approved' || newStatus == 'blocked') {
            // Remove user from the list to avoid duplicates
            users.remove(user);
            // Add new user with the updated status
            users.add({'email': userId, 'status': newStatus});
          }
          break; // Exit loop after updating user
        }
      }
    });
  }

  Future<void> _refreshUsers() async {
    // Simulate a network call or data refresh here
    await Future.delayed(Duration(seconds: 2)); // Simulate loading
    setState(() {
      // You can fetch or update your user data here
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Panel',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Color.fromARGB(255, 161, 161, 163),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
              Tab(text: 'Blocked'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUserList('pending'), // Pending users
            UserListPage(
              status: 'approved',
              users: users,
              onUpdateUserStatus: _updateUserStatus,
              onRefresh: _refreshUsers,
            ), // Approved users
            UserListPage(
              status: 'blocked',
              users: users,
              onUpdateUserStatus: _updateUserStatus,
              onRefresh: _refreshUsers,
            ), // Blocked users
          ],
        ),
      ),
    );
  }

  // Builds the user list for the given status
  Widget _buildUserList(String status) {
    List<Map<String, String>> filteredUsers =
        users.where((user) => user['status'] == status).toList();

    return Container(
      color: const Color.fromARGB(255, 98, 100, 104), // Set the container color
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
                  title: Text(user['email']!,
                      style: TextStyle(color: Colors.white)),
                  trailing: (status ==
                          'pending') // Only show actions for pending users
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () {
                                _showConfirmationDialog(
                                    context, 'approve', user['email']!);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.block, color: Colors.red),
                              onPressed: () {
                                _showConfirmationDialog(
                                    context, 'block', user['email']!);
                              },
                            ),
                          ],
                        )
                      : null,
                );
              },
            ),
          ),
        ],
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
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update user status
                _updateUserStatus(
                    userId, action == 'approve' ? 'approved' : 'blocked');
                Navigator.of(context).pop(); // Close the dialog
                // Show a confirmation message
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

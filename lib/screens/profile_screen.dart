import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({Key? key}) : super(key: key);

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  User? user;
  String firstName = "Loading...";
  String lastName = "Loading...";
  String username = "Loading...";
  String email = "Loading...";
  ImageProvider profileImage = const AssetImage("images/pro.png");
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            user = currentUser;
            firstName = userDoc['firstName'] ?? "No First Name";
            lastName = userDoc['lastName'] ?? "No Last Name";
            username = userDoc['username'] ?? "No Username";
            email = currentUser.email ?? "No Email";
            if (currentUser.photoURL != null) {
              profileImage = NetworkImage(currentUser.photoURL!);
            }
            isLoading = false;
          });
        } else {
          print("User document does not exist.");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print("Current user is null.");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                CircleAvatar(
                  backgroundImage: profileImage,
                  radius: 50,
                ),
                SizedBox(height: 20),
                _buildProfileInfoTile(
                  icon: Icons.person,
                  label: 'Name',
                  value: '$firstName $lastName',
                ),
                _buildProfileInfoTile(
                  icon: Icons.account_circle,
                  label: 'Username',
                  value: '@$username',
                ),
                _buildProfileInfoTile(
                  icon: Icons.email,
                  label: 'Email',
                  value: email,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to the edit profile screen
                      // Add your navigation logic here
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit Profile'),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProfileInfoTile({required IconData icon, required String label, required String value}) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}

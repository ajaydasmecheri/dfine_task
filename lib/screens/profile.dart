import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("userInfo")
            .where("Email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text("There are no users in the database"));
          }

          final userData = snapshot.data!.docs.first.data() as Map<String, dynamic>;

          return GFDrawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                GFDrawerHeader(
                  currentAccountPicture: GFAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                      userData['profilePictureUrl'] ?? 
                      'https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg',
                    ),
                  ),
                  otherAccountsPictures:const [
                    GFAvatar(
                      child: Icon(Icons.edit),
                    ),
                  ],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(userData['fullname']),
                      Text(userData['Email']),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('notification'),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('general'),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('account'),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.warning),
                  title: const Text('about'),
                  onTap: () {
                    
                  },
                ),
                
              ],
            ),
          );
        },
      ),
    );
  }
}

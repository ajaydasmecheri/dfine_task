// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfine_task/routers.dart';
import 'package:dfine_task/widgets/conpontes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController entertaskname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(onPressed: (){
          Navigator.pushNamed(context, Routers.profilepage);
        }, icon: const Icon(Icons.person)),
        title: const Center(child: Text("categories")),
        actions: [IconButton(onPressed: () {
        }, icon: const Icon(Icons.search))],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(26, 166, 159, 159),
                  spreadRadius: 1,
                )
              ],
            ),
            width: 100,
            height: 100,
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Add task Title'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              textfromfield("enter task name", entertaskname)
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('create task'),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection("task")
                                  .add({
                                "taskname": entertaskname.text.trim(),
                                "useremail":
                                    FirebaseAuth.instance.currentUser!.email,
                              });
                              entertaskname.clear();

                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("task").where("useremail",
                isEqualTo: FirebaseAuth.instance.currentUser?.email).snapshots(),
              builder: (BuildContext context, snapshot) {
                final data = snapshot.data?.docs;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (data!.isEmpty) {
                  return const Center(child: Text("there are no task"));
                } else {
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final taskdata = data[index].data();
                        return GestureDetector(
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      taskdata["taskname"],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: (){
                             Navigator.pushNamed(context, Routers.addtask, arguments: {
                                        "taskname":taskdata["taskname"],
                                      });
                          },
                          
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}



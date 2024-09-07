// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfine_task/widgets/conpontes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  TextEditingController addtask = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final taskargs = ModalRoute.of(context)!.settings.arguments as Map?;


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [textfromfield("type your task", addtask)],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('add task'),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("addtask")
                          .add({
                            "tasktitle":taskargs?["taskname"],
                        "taskname": addtask.text.trim(),
                        "useremail": FirebaseAuth.instance.currentUser!.email,
                      });
                      addtask.clear();

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        mini: true,
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
      body:SafeArea(
        child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("addtask").
                where("useremail",
                  isEqualTo: FirebaseAuth.instance.currentUser?.email).
                  where("tasktitle", isEqualTo: taskargs?["taskname"]).
                  snapshots(),
                builder: (BuildContext context, snapshot) {
                  final data = snapshot.data?.docs;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (data!.isEmpty) {
                    return const Center(child: Text("there are no task"));
                  } else {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final taskdata = data[index].data();
                          return Card(
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
                          );
                        });
                  }
                },
              ),
      ),
    );

    




  }
}






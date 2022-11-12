import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_odm/model/user.dart';
import 'package:flutter_fire_odm/screens/add_update_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 💙 Firebase'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddUpdateScreen(
                state: ScreenState.add,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FirestoreBuilder<UserQuerySnapshot>(
        ref: usersRef,
        builder: (
          context,
          AsyncSnapshot<UserQuerySnapshot> snapshot,
          Widget? child,
        ) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading...'));
          }

          // Access the QuerySnapshot
          UserQuerySnapshot querySnapshot = snapshot.requireData;

          return ListView.builder(
            itemCount: querySnapshot.docs.length,
            itemBuilder: (context, index) {
              // Access the User instance
              User user = querySnapshot.docs[index].data;

              String id = querySnapshot.docs[index].reference.id;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(user.name)),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AddUpdateScreen(
                              state: ScreenState.update,
                              id: id,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        usersRef.doc(id).delete();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_crud/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text field controller
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();

  // Search text field controller
  final TextEditingController searchController = TextEditingController();

  // Firestore service
  final FirestoreService firestoreService = FirestoreService();

  // open dialog box to add notes
  void _openNoteBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add Note'),
              content: SizedBox(
                height: 100,
                width: 50,
                child: Column(
                  children: [
                    TextField(
                      controller: nameTextController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Note',
                      ),
                      autofocus: true,
                    ),
                    TextField(
                      controller: descTextController,
                      decoration: const InputDecoration(
                        hintText: 'Enter description',
                      ),
                      autofocus: true,
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // add note
                    firestoreService.createNote(
                        nameTextController.text, descTextController.text);

                    // clear text fields
                    nameTextController.clear();
                    descTextController.clear();

                    // close dialog
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                )
              ],
            ));
  }

  // open dialog box to delete notes
  void _deleteNote(String id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(child: Text('Delete Note')),
              content: const SizedBox(
                height: 50,
                child: Column(
                  children: [
                    Text('Are you sure you want to delete this note?'),
                    Text(
                      'This action cannot be undone!',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          firestoreService.deleteNote(id);

                          Navigator.pop(context);
                        },
                        child: const Text('Delete')),
                  ],
                )
              ],
            ));
  }

  // Open dialog to update notes
  void _updateNote(String id, String name, String desc) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Update Note'),
              content: SizedBox(
                height: 100,
                width: 50,
                child: Column(
                  children: [
                    TextField(
                      controller: nameTextController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Note',
                      ),
                      autofocus: true,
                    ),
                    TextField(
                      controller: descTextController,
                      decoration: const InputDecoration(
                        hintText: 'Enter description',
                      ),
                      autofocus: true,
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    // add note
                    firestoreService.updateNote(
                        id, nameTextController.text, descTextController.text);

                    // clear text fields
                    nameTextController.clear();
                    descTextController.clear();

                    // close dialog
                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                )
              ],
            ));
  }

  // Search notes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: _buildDrawer(),
        ),
        appBar: AppBar(
          title: const Card(
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search...',
                  icon: Padding(
                    padding: EdgeInsets.only(left: 10, right: 1),
                    child: Icon(Icons.search),
                  ),
                  border : InputBorder.none),
            ),
          ),
          centerTitle: true,
          toolbarHeight: 70,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openNoteBox,
          child: const Icon(Icons.add),
        ),
        body: _buildNoteList());
  }

  Widget _buildNoteList() {
    return StreamBuilder(
        stream: firestoreService.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          // Adds a box shadow to the container.
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 4))
                          ]),
                      child: ListTile(
                          title: Text(
                            snapshot.data?.docs[index]['note'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data?.docs[index]['description']),
                            ],
                          ),
                          trailing: Wrap(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.update_rounded),
                                onPressed: () {
                                  _updateNote(
                                      snapshot.data!.docs[index].id,
                                      snapshot.data!.docs[index]['note'],
                                      snapshot.data!.docs[index]
                                          ['description']);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_rounded),
                                onPressed: () {
                                  _deleteNote(snapshot.data!.docs[index].id);
                                },
                              ),
                            ],
                          )),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text('No Data Found'),
            );
          }
        });
  }

  Widget _buildDrawer() {
    return ListView(
      children: [
        const SizedBox(
          height: 100,
          child: DrawerHeader(
            curve: Curves.easeIn,
            child: Text('Simple CRUD'),
          ),
        ),
        ListTile(
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
          title: const Text('Home'),
        ),
        ListTile(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sunny),
          ),
          title: const Text('Dark Mode'),
        )
      ],
    );
  }
}

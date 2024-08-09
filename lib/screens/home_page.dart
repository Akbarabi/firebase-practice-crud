import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_crud/screens/signin_page.dart';
import 'package:simple_crud/services/firestore.dart';
import 'package:flutter/gestures.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text field controller
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();

  // Search controller
  final TextEditingController searchController = TextEditingController();
  List<QueryDocumentSnapshot> searchResult = [];

  // Firestore service
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_searchNotes);
  }

  @override
  void dispose() {
    searchController.removeListener(_searchNotes);
    searchController.dispose();
    super.dispose();
  }

  void _searchNotes() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        searchResult = [];
      } else {
        firestoreService.searchNotes(query).listen((snapshot) {
          setState(() {
            searchResult = snapshot.docs;
          });
        });
      }
    });
  }

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

  // Get user credential
  bool _checkUserCredential() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  // Boolean Text 'Login' or 'Logout'
  Widget _getText() {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: _checkUserCredential() ? 'Logout' : 'Login',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (_checkUserCredential()) {
                  // Implement logout logic
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()));
                }
              })
      ]),
    );
  }

  // Boolean Icon 'Login' or 'Logout'
  Widget _getLoginIcon() {
    return _checkUserCredential()
        ? IconButton(
            onPressed: () {
              // Implementasi logout di sini
            },
            icon: const Icon(Icons.logout),
            hoverColor: Colors.transparent,
          )
        : IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignInPage()));
            },
            icon: const Icon(Icons.login),
            hoverColor: Colors.transparent,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: _buildDrawer(),
        ),
        appBar: AppBar(
          title: _searchNotesWidget(),
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
        stream: searchResult.isEmpty
            ? firestoreService.getNotes()
            : firestoreService.searchNotes(searchController.text),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = searchResult.isEmpty ? snapshot.data!.docs : searchResult;

            return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 4))
                          ]),
                      child: ListTile(
                          title: Text(
                            notesList[index]['note'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notesList[index]['description']),
                            ],
                          ),
                          trailing: Wrap(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.update_rounded),
                                onPressed: () {
                                  _updateNote(
                                      notesList[index].id,
                                      notesList[index]['note'],
                                      notesList[index]['description']);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_rounded),
                                onPressed: () {
                                  _deleteNote(notesList[index].id);
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            const DrawerHeader(
              curve: Curves.easeIn,
              child: Text('Simple CRUD'),
            ),
            ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home),
                hoverColor: Colors.transparent,
              ),
              title: RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Home',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }),
              ])),
            ),
            ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.sunny),
                hoverColor: Colors.transparent,
              ),
              title: const Text('Dark Mode'),
            ),
          ],
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: _getLoginIcon(),
                title: _getText(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchNotesWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 320,
        height: 70,
        child: Row(
          children: [
            Card(
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                      label: Text('Search'),
                      icon: Padding(
                        padding: EdgeInsets.only(left: 10, right: 1),
                        child: Icon(Icons.search),
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

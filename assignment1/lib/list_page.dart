import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Users>> fetchUser() async {
  final response = await http
      .get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));

  if (response.statusCode == 200) {
    List<dynamic> _parsedListJson = jsonDecode(response.body);
    List<Users> _itemList = List<Users>.from(
      _parsedListJson.map(
        (dynamic element) {
          return Users.fromJson(element);
        },
      ),
    );
    return _itemList;
  } else {
    throw Exception('Failed to load users');
  }
}

class Users {
  final String name;
  final String email;
  final String body;

  Users({required this.name, required this.email, required this.body});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(name: json['name'], email: json['email'], body: json['body']);
  }
}

class UserUi extends StatefulWidget {
  const UserUi({Key? key}) : super(key: key);

  @override
  _UserUiState createState() => _UserUiState();
}

class _UserUiState extends State<UserUi> {
  late Future<List<Users>> _userList;

  @override
  void initState() {
    super.initState();
    _userList = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('comments', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Users>>(
          future: _userList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  var item = snapshot.data![i];
                  return InkWell(
                    onTap: () => showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: double.maxFinite,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Name: ${item.name}'),
                                Text('Email: ${item.email}'),
                                Text('Body: ${item.body}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            (i + 1).toString(),
                            style: const TextStyle(color: Colors.white),
                            // Display the index as text
                          ),
                        ),
                        title: Text(item.name),
                        // You can also display 'item.body' if needed
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return const Text("No data");
            }
          },
        ),
      ),
    );
  }
}

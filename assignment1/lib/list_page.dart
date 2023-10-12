import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:assignment1/model.dart';
import 'package:http/http.dart' as http;

Future<List<APIData>> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    List<dynamic> parsedListJson = jsonDecode(response.body);

    List<APIData> itemsList = List<APIData>.from(
        parsedListJson.map<APIData>((dynamic i) => APIData.fromJson(i)));
    return itemsList;
  } else {
    throw Exception('Failed to load album');
  }
}

class ListPageAss extends StatefulWidget {
  const ListPageAss({super.key});

  @override
  State<ListPageAss> createState() => _ListPageAssState();
}

class _ListPageAssState extends State<ListPageAss> {
  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  Widget _customCard(APIData obj, int num) {
    return Card(
      child: ListTile(
        onTap: () => _showModal(context, obj),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
              child: Center(
                child: Text(
                  num.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(child: Text(obj.name)),
          ],
        ),
      ),
    );
  }

  void _showModal(BuildContext context, APIData obj) {
    double totalHeight =
        (obj.name.length + obj.email.length + obj.body.length) * 1.0;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: totalHeight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${obj.name}"),
                Text("Email: ${obj.email}"),
                Text("Body: ${obj.body}")
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Comments', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
          future: fetchAlbum(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return InkWell(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, i) {
                    var item = snapshot.data![i];
                    return _customCard(item, i + 1);
                  },
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

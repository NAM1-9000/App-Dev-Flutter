import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appdev_quiz_22735/model.dart';

Future<List<APIDataModel>> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));

  if (response.statusCode == 200) {
    List<dynamic> parsedListJson = jsonDecode(response.body);

    List<APIDataModel> itemsList = List<APIDataModel>.from(parsedListJson
        .map<APIDataModel>((dynamic i) => APIDataModel.fromJson(i)));
    return itemsList;
  } else {
    throw Exception('Failed to load album');
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  Widget _customCard(APIDataModel obj) {
    return Card(
      child: InkWell(
        child: ListTile(
          onTap: () => _showUserDetails(context, obj),
          leading: Image.network("${obj.imageLink}"),
          title: Text("${obj.name}"),
          trailing: Text("\$ ${obj.price}"),
        ),
      ),
    );
  }

  void _showUserDetails(BuildContext context, APIDataModel user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Wrap(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "${user.imageLink}",
                    scale: 2,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${user.name}\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text('${user.description}'),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Align items at both ends
                children: [
                  Text('Brand: ${user.brand}'),
                  Text('Price: \$ ${user.price}'),
                ],
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Align items at both ends
                children: [
                  Text('Product Type: ${user.productType}'),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Rating: ',
                          style:
                              TextStyle(color: Colors.black), // Default color
                        ),
                        TextSpan(
                          text: user.rating.toString(),
                          style: const TextStyle(
                              color: Colors.red), // Red color for user.rating
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...user.productColors!.map(
                    (nigga) {
                      return CircleAvatar(
                        backgroundColor: Color(int.parse(
                                nigga.hexValue!.substring(1, 7),
                                radix: 16) +
                            0xFF000000),
                      );
                    },
                  )
                ],
              ),
            ],
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
        title: const Text("Products", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              print("Menu Button");
            },
            icon: const Icon(
              Icons.menu,
              semanticLabel: "menu",
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<List<APIDataModel>>(
          future: fetchAlbum(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return InkWell(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, i) {
                    var item = snapshot.data![i];
                    return _customCard(item);
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

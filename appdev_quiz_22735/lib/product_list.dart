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
        return SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${user.id}'),
                Text('Brand: ${user.brand}'),
                Text('Name: ${user.name}'),
                Text('Price: ${user.price}'),
                Image.network("${user.imageLink}"),
                Text('Image Link: ${user.imageLink}'),
                Text('Product Link: ${user.productLink}'),
                Text('Website Link: ${user.websiteLink}'),
                Text('Description: ${user.description}'),
                Text('Rating: ${user.rating}'),
                Text('Product Type: ${user.productType}'),
                Text('Created At: ${user.createdAt}'),
                Text('Updated At: ${user.updatedAt}'),
                Text('Product API URL: ${user.productApiUrl}'),
                Text('API Featured Image: ${user.apiFeaturedImage}'),
                Text('Product Colors: ${user.productColors}'),
                // Add more fields as needed
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
        title: const Text("Products", style: TextStyle(color: Colors.white)),
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

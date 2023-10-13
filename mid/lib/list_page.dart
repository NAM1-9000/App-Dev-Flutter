import 'package:flutter/material.dart';
import 'package:mid/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Products>> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    if (data.containsKey("products") && data["products"] is List) {
      List<dynamic> jsonList = data["products"];

      List<Products> productsList = jsonList.map((json) {
        return Products.fromJson(json);
      }).toList();

      return productsList;
    } else {
      throw Exception('Products data not found or is not a list.');
    }
  } else {
    throw Exception('Failed to load products');
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  Widget _customCard(Products obj) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: InkWell(
        child: Stack(
          children: [
            Image.network(
              "${obj.thumbnail}",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                color: Colors.black.withOpacity(1),
                child: GridTileBar(
                  title: Row(
                    children: [
                      Text(
                        obj.title.length > 20
                            ? obj.title.substring(0, 20)
                            : obj.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            "${obj.price} USD  ",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              onTap: () => _showProductDetails(context, obj),
                              child: const Icon(
                                Icons.remove_red_eye_sharp,
                              ))
                        ],
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "${obj.description}",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(BuildContext context, Products obj) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: obj.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        obj.images[index],
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                obj.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text("${obj.description}"),
              Text("\$ ${obj.price}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text("${obj.rating}"),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text("${obj.discountPercentage}%"),
                      const Icon(
                        Icons.discount,
                        color: Colors.blue,
                      )
                    ],
                  ),
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
        backgroundColor: Colors.white,
        title: const Text("Products", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: FutureBuilder<List<Products>>(
          future: fetchAlbum(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return InkWell(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 16 / 9,
                  ),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, i) {
                    var item = snapshot.data![i];
                    return _customCard(item);
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do/models/product_model.dart';
import 'package:to_do/widgets/grid_card.dart';

Future<List<Product>> fetchProducts() async {
  try {
    final response = await http.get(
      Uri.parse(
        "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline",
      ),
    );

    List<dynamic> parsedJsonList = jsonDecode(response.body);

    List<Product> products = parsedJsonList
        .map(
          (product) => Product.fromJson(product),
        )
        .toList();

    return products;
  } catch (error) {
    throw Exception(error);
  }
}

class CustomGrid extends StatefulWidget {
  const CustomGrid({super.key});

  @override
  State<CustomGrid> createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  late Future<List<Product>> products;

  void showModal(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Maybelline Face Studio Master Hi-Light Light Booster Bronzer',
                            style: TextStyle(
                                fontSize: 14.5, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "Maybelline Face Studio Master Hi-Light Light Boosting bronzer formula has an expert \nbalance of shade + shimmer illuminator for natural glow. Skin goes \nsoft-lit with zero glitz.\n\n\t\tFor Best Results: Brush over all shades in palette and gently sweep over \ncheekbones, brow bones, and temples, or anywhere light naturally touches\n the face.\n\n\t\t\n\t\n\n                    "
                              // .replaceAll("\n", ""),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Brand: maybelline'),
                    Text('Price: \$14.99'),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Product type: bronzer'),
                    Text('Rating: 5.0'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5.0),
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5.0),
                      child: const CircleAvatar(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    products = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                var product = snapshot.data![index];

                return GridCard(
                  product: product,
                  showModal: (context) {
                    showModal(context);
                  },
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

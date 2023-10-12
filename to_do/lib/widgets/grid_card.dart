import 'package:flutter/material.dart';
import 'package:to_do/models/product_model.dart';

class GridCard extends StatelessWidget {
  const GridCard({super.key, required this.product, required this.showModal});

  final Product product;
  final void Function(BuildContext context) showModal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: InkWell(
          onTap: () => showModal(context),
          child: GridTile(
            footer: GridTileBar(
              title: Text(product.name!),
              backgroundColor: Colors.green,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    product.imageLink!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

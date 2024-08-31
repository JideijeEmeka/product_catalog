import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product_catalog_app/adapter/product.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;
  const ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        },),
        title: const Text("Product Details",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 20, top: 10, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withOpacity(0.2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Text(product.name.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.memory(product.image, fit: BoxFit.fill))),
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text("Description",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                ),
                Text(product.description,
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text("Category",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                ),
                Text(product.category,
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text("Price",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                ),
                Text("₦${product.price}",
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
              ],
            ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_catalog_app/adapter/boxes.dart';
import 'package:product_catalog_app/adapter/product.dart';
import 'package:product_catalog_app/functions/select_image.dart';
import 'package:product_catalog_app/models/product.dart';
import 'package:provider/provider.dart';

filterProductSheet(BuildContext context,
    ) {

  int index = 0;
  bool applied = false;
  List categories = [
    {
      "selected": false,
      "category": context.read<ProductSate>().categories[0],
    },
    {
      "selected": false,
      "category": context.read<ProductSate>().categories[1],
    },
    {
      "selected": false,
      "category": context.read<ProductSate>().categories[2],
    },
    {
      "selected": false,
      "category": context.read<ProductSate>().categories[3],
    },
  ];

  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      //backgroundColor: Colors.grey.withOpacity(0.1),
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: StatefulBuilder(
              builder: (context, setState) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Text("Filter products by category",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text("Categories",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: context.read<ProductSate>().categories.length,
                            itemBuilder: (ctx, i) {
                          return CheckboxListTile(
                              value: categories[i]["selected"],
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(categories[i]["category"]),
                              onChanged: (val) {
                                context.read<ProductSate>().filtered(categories, i, val!);
                                setState((){
                                  index = i;
                                  applied = val;
                                });
                              });
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: ElevatedButton(onPressed: () {
                              context.read<ProductSate>().applyFilter(categories, index, applied);
                              Navigator.pop(context);
                            },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.green
                                ),
                                child: const Text("Apply filter")),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          ),
        );
      });
}

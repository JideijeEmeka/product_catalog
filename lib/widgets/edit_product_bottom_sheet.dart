import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_catalog_app/adapter/boxes.dart';
import 'package:product_catalog_app/adapter/product.dart';
import 'package:product_catalog_app/functions/select_image.dart';
import 'package:product_catalog_app/models/product.dart';
import 'package:provider/provider.dart';

editProductSheet(BuildContext context,
    String name,
    String description,
    String price,
    String category,
    Uint8List image,
    int i,
    List? filteredProducts,
    Function? save
    ) {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  String img = "";

  nameController.text = name;
  descriptionController.text = description;
  priceController.text = price;
  categoryController.text = category;

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
          heightFactor: 0.9,
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
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text("Edit this product",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                        ),
                        TextFormField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              hintText: "Enter name of product",
                              label: Text("Name"),
                              border: OutlineInputBorder()
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Name cannot be empty";
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 20),
                          child: TextFormField(
                            controller: descriptionController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                hintText: "describe the product",
                                label: Text("Description"),
                                border: OutlineInputBorder()
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Description cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              label: Text("Price"),
                              hintText: "price of product",
                              border: OutlineInputBorder()
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Price cannot be empty";
                            }
                            return null;
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 20),
                            child: TextFormField(
                              readOnly: true,
                              controller: categoryController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: "commodities",
                                border: const OutlineInputBorder(),
                                label: const Text("category"),
                                suffixIcon: DropdownButton<String>(
                                  padding: const EdgeInsets.only(right: 20),
                                  underline: const SizedBox(height: 0, width: 0,),
                                  items: <String>['Commodities', 'Edibles',
                                    'Beverages', 'Snacks'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                      onTap: () {
                                        categoryController.text = value;
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {  },
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Category cannot be empty";
                                }
                                return null;
                              },
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed: () async {
                              final res = await SelectImage.pickImage();
                              setState(() {
                                img = res;
                              });},
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.green
                                ),
                                child: const Text("Edit Image")),
                            image.isEmpty ? const SizedBox() :
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 1.5
                                  ),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: img.isEmpty
                                      ? Image.memory(image, fit: BoxFit.fill)
                                      : Image.memory(File(img).readAsBytesSync(),
                                    fit: BoxFit.fill)),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  boxProducts.putAt(i,
                                    Product(
                                      name: nameController.text,
                                      description: descriptionController.text,
                                      category: categoryController.text,
                                      image: img.isEmpty ? image : File(img).readAsBytesSync(),
                                      price: priceController.text));
                                });
                                if(filteredProducts!.isNotEmpty) {
                                  setState(() {});
                                  filteredProducts[i].name = nameController.text;
                                  filteredProducts[i].description = descriptionController.text;
                                  filteredProducts[i].category = categoryController.text;
                                  filteredProducts[i].price = priceController.text;
                                  filteredProducts[i].image = img.isEmpty
                                      ? image
                                      : File(img).readAsBytesSync();
                                  boxProducts.putAt(i, Product(
                                      name: filteredProducts[i].name,
                                      description: filteredProducts[i].description,
                                      category: filteredProducts[i].category,
                                      image: filteredProducts[i].image,
                                      price: filteredProducts[i].price));
                                  Navigator.pop(context);
                                  save?.call();
                                  return;
                                }
                                Navigator.pop(context);
                                save?.call();
                              },
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.green
                              ),
                              child: const Text("Save")),
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

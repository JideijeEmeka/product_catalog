import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:product_catalog_app/adapter/boxes.dart';
import 'package:product_catalog_app/adapter/product.dart';
import 'package:product_catalog_app/functions/select_image.dart';
import 'package:product_catalog_app/models/product.dart';
import 'package:product_catalog_app/views/product_detail_view.dart';
import 'package:product_catalog_app/widgets/dialog.dart';
import 'package:product_catalog_app/widgets/edit_product_bottom_sheet.dart';
import 'package:product_catalog_app/widgets/filter_products_widget.dart';
import 'package:provider/provider.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController categoryCon = TextEditingController();
  TextEditingController imageCon = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String image = "";
  String imageError = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text("Product Catalog",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17),
            ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameCon,
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
                          controller: descriptionCon,
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
                        controller: priceCon,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
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
                          controller: categoryCon,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "commodities",
                            border: const OutlineInputBorder(),
                            label: const Text("category"),
                            suffixIcon: DropdownButton<String>(
                              padding: const EdgeInsets.only(right: 20),
                              underline: const SizedBox(height: 0, width: 0,),
                              items: context.read<ProductSate>().categories.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {
                                    categoryCon.text = value;
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
                              image = res;
                              imageError = "";
                            });},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.green
                              ),
                              child: const Text("Add Image")),
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
                                child: Image.memory(File(image).readAsBytesSync(), fit: BoxFit.fill,)),
                          )
                        ],
                      ),
                    Text(imageError, style: const TextStyle(color: Colors.red),),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: context.watch<ProductSate>().isLoading
                          ? const CircularProgressIndicator() :
                        ElevatedButton(onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            if(image.isEmpty) {
                              setState(() {
                                imageError = "Kindly, add an image";
                              });
                              return;
                            }
                            context.read<ProductSate>().setLoader(true);
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                boxProducts.put("add_${nameCon.text}",
                                    Product(
                                        name: nameCon.text,
                                        description: descriptionCon.text,
                                        category: categoryCon.text,
                                        image: File(image).readAsBytesSync(),
                                        price: priceCon.text));
                                image = "";
                              });
                              nameCon.clear();
                              descriptionCon.clear();
                              categoryCon.clear();
                              priceCon.clear();
                              context.read<ProductSate>().setLoader(false);
                            });
                          }
                        },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.green
                            ),
                            child: const Text("Add")),
                      )
                    ],
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: boxProducts.isEmpty ? const Center(child: Text("No Products available")) :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Products",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                          IconButton(onPressed: () {
                            filterProductSheet(context);
                          },
                              icon: const Icon(Icons.filter_alt_outlined))
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: context.watch<ProductSate>().filter
                         ? boxProducts.values.where((e) => e.category
                           == context.watch<ProductSate>().selectedCategory).length
                         : boxProducts.length,
                      physics: const ScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        List filteredProducts = boxProducts.values.where((e) => e.category
                            == context.watch<ProductSate>().selectedCategory).toList();
                        Product product = boxProducts.getAt(i);
                        return ListTile(
                          onTap: () {
                            if(context.read<ProductSate>().filter) {
                              Product filteredProduct = filteredProducts[i];
                              Navigator.push(context, PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 300),
                                  child: ProductDetailView(product: filteredProduct)));
                              return;
                            }
                            Navigator.push(context, PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 300),
                                child: ProductDetailView(product: product)));
                          },
                          leading: CircleAvatar(
                            radius: 17,
                            backgroundImage: context.watch<ProductSate>().filter
                                ? MemoryImage(filteredProducts[i].image)
                                : MemoryImage(product.image),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          title: context.watch<ProductSate>().filter
                            ? Text(filteredProducts[i].name.toUpperCase())
                            : Text(product.name.toUpperCase()),
                          subtitle: context.watch<ProductSate>().filter
                              ? Text(filteredProducts[i].category.toUpperCase())
                              : Text(product.category),
                          onLongPress: () {
                            if(context.read<ProductSate>().filter) {
                              Product filteredProduct = filteredProducts[i];
                              editProductSheet(context,
                                  filteredProduct.name,
                                  filteredProduct.description,
                                  filteredProduct.price,
                                  filteredProduct.category,
                                  filteredProduct.image, i, () {
                                    setState(() {});
                                  });
                              return;
                            }
                            editProductSheet(context,
                                product.name,
                                product.description,
                                product.price,
                                product.category,
                                product.image, i, () {
                                  setState(() {});
                            });
                          },
                          trailing: GestureDetector(
                              onTap: () {
                                showAppDialog(context,
                                    "Are you sure?",
                                    "This action will delete this product", () {
                                      setState(() {
                                        boxProducts.deleteAt(i);
                                      });
                                    });
                              },
                              child: const Icon(Icons.clear)),
                        );
                      }),
                  ],
                ),
            ),
              boxProducts.isEmpty ? const SizedBox() :
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 30),
                child: ElevatedButton(onPressed: () {
                  showAppDialog(context,
                      "Are you sure?",
                      "This action will delete all products", () {
                        setState(() {
                          boxProducts.clear();
                        });
                        setState(() {});
                      });},
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(Icons.delete),
                        ),
                        Text("Delete all products"),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

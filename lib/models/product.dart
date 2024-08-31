import 'package:flutter/cupertino.dart';

class ProductSate extends ChangeNotifier {
  String? name;
  String? description;
  String? price;
  String? category;
  String? image;
  bool isLoading = false;

  ProductSate({
    this.image, this.category, this.price, this.description, this.name
  });

  void setLoader(bool status) {
    isLoading = status;
    notifyListeners();
  }

}
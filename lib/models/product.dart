import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class ProductSate extends ChangeNotifier {
  String? name;
  String? description;
  String? price;
  String? category;
  String? image;
  String? selectedCategory;

  bool isLoading = false;
  bool filter = false;

  List<dynamic> products = [];
  List<String> categories = ['Commodities', 'Edibles', 'Beverages', 'Snacks'];

  ProductSate({
    this.image, this.category, this.price, this.description, this.name
  });

  void setLoader(bool status) {
    isLoading = status;
    notifyListeners();
  }

  void filtered(List c, int i, bool status) {
    for (var e in c) {
      e["selected"] = false;
    }
    c[i]["selected"] = status;
    notifyListeners();
  }

  void applyFilter(List c, int i, bool status) {
    filter = status;
    selectedCategory = c[i]['category'];
    notifyListeners();
  }

  void update(Box<dynamic> p) {
    products = p as List;
    notifyListeners();
  }

}
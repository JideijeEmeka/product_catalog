import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class ProductState extends ChangeNotifier {
  String? name;
  String? description;
  String? price;
  String? category;
  String? image;
  String? selectedCategory;

  bool isLoading = false;
  bool isLoadingDelete = false;
  bool filter = false;

  List<dynamic> products = [];
  List<String> categories = ['Commodities', 'Edibles', 'Beverages', 'Snacks'];

  ProductState({
    this.image, this.category, this.price, this.description, this.name
  });

  void setLoader(bool status) {
    isLoading = status;
    notifyListeners();
  }

  void setDeleteLoader(bool status) {
    isLoadingDelete = status;
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

  void delete(Box<dynamic> box) {
    box.clear();
    notifyListeners();
  }

  void update(Box<dynamic> p) {
    products = p as List;
    notifyListeners();
  }

}
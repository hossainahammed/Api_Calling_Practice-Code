import 'dart:convert';

import '../Models/productModel.dart';
import 'package:http/http.dart' as http;

import '../utils/urls.dart';

class ProductController {
  List<Data> products = [];

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      productModel model = productModel.fromJson(data);
      products = model.data ?? [];
    }
  }

  Future<bool> DeleteProducts(String productId) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(productId)));

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }
}

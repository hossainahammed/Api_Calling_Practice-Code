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
  Future<void> CreateProducts(String productName, String img, int qty, int UnitPrice, int totalPrice) async {
    final response = await http.post(
      Uri.parse(Urls.createdProduct),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": productName,
        "ProductCode": DateTime.now().microsecondsSinceEpoch.toString(),  // Converted to string
        "Img": img,
        "Qty": qty,
        "UnitPrice": UnitPrice,
        "TotalPrice": totalPrice,
      }),
    );

    if (response.statusCode == 201) {

      await fetchProducts();
    } else {

      throw Exception('Failed to create product: ${response.statusCode} ${response.body}');
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

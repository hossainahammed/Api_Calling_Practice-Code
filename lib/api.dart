import 'package:flutter/material.dart';
import 'package:practicecode/Controller/productController.dart';
import 'package:practicecode/Models/productModel.dart';  // Import your model file (adjust path if needed)
import 'widget/productCard.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  final ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
    // Fetch products asynchronously and update UI when done
    productController.fetchProducts().then((_) {
      setState(() {});  // Refresh the UI after data is loaded
    }).catchError((error) {
      // Optional: Handle errors (e.g., show a snackbar or log)
      print('Error fetching products: $error');
    });
  }

  // Updated dialog to handle both add and edit
  void productDialouge({bool isEdit = false, Data? product}) {
    TextEditingController productNameController = TextEditingController(
      text: isEdit ? product?.productName ?? '' : '',
    );
    TextEditingController productQTYController = TextEditingController(
      text: isEdit ? product?.qty?.toString() ?? '' : '',
    );
    TextEditingController productImageController = TextEditingController(
      text: isEdit ? product?.img ?? '' : '',
    );
    TextEditingController productUnitPriceController = TextEditingController(
      text: isEdit ? product?.unitPrice?.toString() ?? '' : '',
    );
    TextEditingController productTotalPriceController = TextEditingController(
      text: isEdit ? product?.totalPrice?.toString() ?? '' : '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'Edit Product' : 'Add Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: productNameController,
              decoration: InputDecoration(labelText: 'Product name'),
            ),
            TextField(
              controller: productImageController,
              decoration: InputDecoration(labelText: 'Product Image'),
            ),
            TextField(
              controller: productQTYController,
              decoration: InputDecoration(labelText: 'Product Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: productUnitPriceController,
              decoration: InputDecoration(labelText: 'Product Unit Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: productTotalPriceController,
              decoration: InputDecoration(labelText: 'Product Total price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () async {
                    // Basic validation
                    if (productNameController.text.isEmpty ||
                        productImageController.text.isEmpty ||
                        productQTYController.text.isEmpty ||
                        productUnitPriceController.text.isEmpty ||
                        productTotalPriceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }
                    int? qty, unitPrice, totalPrice;
                    try {
                      qty = int.parse(productQTYController.text);
                      unitPrice = int.parse(productUnitPriceController.text);
                      totalPrice = int.parse(productTotalPriceController.text);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid number format')),
                      );
                      return;
                    }

                    try {
                      if (isEdit && product != null) {
                        // Update existing product
                        await productController.UpdateProducts(
                          product.sId.toString(),  // Assuming sId is the ID
                          productNameController.text,
                          productImageController.text,
                          qty,
                          unitPrice,
                          totalPrice,
                        );
                      } else {
                        // Create new product
                        await productController.CreateProducts(
                          productNameController.text,
                          productImageController.text,
                          qty,
                          unitPrice,
                          totalPrice,
                        );
                      }
                      // Refresh the list after successful operation
                      await productController.fetchProducts();
                      setState(() {});
                      Navigator.pop(context);  // Close dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(isEdit ? 'Product Updated Successfully' : 'Product Added Successfully')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  },
                  child: Text(isEdit ? 'Update Product' : 'Add Product'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api calling'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialouge(),  // For adding (no params needed)
        child: Icon(Icons.add),
      ),
      body: GridView.builder(
        itemCount: productController.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          var product = productController.products[index];
          return ProductCard(
            onEdit: () {
              productDialouge(isEdit: true, product: product);  // Pass edit mode and product
            },
            onDelete: () {
              productController.DeleteProducts(product.sId.toString()).then((value) async {
                if (value) {
                  await productController.fetchProducts();
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Product Deleted'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Something Wrong'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              });
            },
            product: productController.products[index],
          );
        },
      ),
    );
  }
}
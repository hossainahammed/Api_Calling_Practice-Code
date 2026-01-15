import 'package:flutter/material.dart';
import 'package:practicecode/Controller/productController.dart';
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

  @override
  Widget build(BuildContext context) {
    void productDialouge() {
      TextEditingController productNameController = TextEditingController();
      TextEditingController productQTYController = TextEditingController();
      TextEditingController productImageController = TextEditingController();
      TextEditingController productUnitPriceController = TextEditingController();
      TextEditingController productTotalPriceController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: productNameController,  // Added controller
                decoration: InputDecoration(labelText: 'Product name'),
              ),
              TextField(
                controller: productImageController,  // Added controller
                decoration: InputDecoration(labelText: 'Product Image'),
              ),
              TextField(
                controller: productQTYController,  // Added controller
                decoration: InputDecoration(labelText: 'Product Quantity'),
              ),
              TextField(
                controller: productUnitPriceController,  // Added controller
                decoration: InputDecoration(labelText: 'Product Unit Price'),
              ),
              TextField(
                controller: productTotalPriceController,  // Added controller
                decoration: InputDecoration(labelText: 'Product Total price'),
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

                      try {
                        await productController.CreateProducts(
                          productNameController.text,
                          productImageController.text,
                          int.parse(productQTYController.text),
                          int.parse(productUnitPriceController.text),
                          int.parse(productTotalPriceController.text),
                        );
                        // Refresh the list after successful creation
                        await productController.fetchProducts();
                        setState(() {});
                        Navigator.pop(context);  // Close dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Product Added Successfully')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    },
                    child: Text('Add Product'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Api calling'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialouge(),
        child: Icon(Icons.add),
      ),

      body: GridView.builder(
       // itemCount:productController.products.length,
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
              productDialouge();
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

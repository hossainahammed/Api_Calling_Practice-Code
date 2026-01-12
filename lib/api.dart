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
    // TODO: implement initState
    super.initState();
    setState(() {
      productController.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    void productDialouge() {
      TextEditingController productNameController = TextEditingController();
      TextEditingController productQTYController = TextEditingController();
      TextEditingController productImageController = TextEditingController();
      TextEditingController productUnitPriceController =
          TextEditingController();
      TextEditingController productTotalPriceController =
          TextEditingController();

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Add product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Product name'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Product Image'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Product Quantity'),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Product Unit Price',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Product Total price',
                    ),
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
                        onPressed: () {},
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
        itemCount: 10,
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

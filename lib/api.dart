import 'package:flutter/material.dart';

import 'widget/productCard.dart';

class ApiCall extends StatelessWidget {
  const ApiCall({super.key});

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
          return ProductCard();
        },
      ),
    );
  }
}



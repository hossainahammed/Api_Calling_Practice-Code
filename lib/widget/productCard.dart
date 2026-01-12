import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 140,
            child: Image.network(
              height: 100,
              fit: BoxFit.cover,
              'https://i.guim.co.uk/img/media/18badfc0b64b09f917fd14bbe47d73fd92feeb27/189_335_5080_3048/master/5080.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=1562112c7a64da36ae0a5e75075a0d12',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text('Product name',style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54
                ),),
                Text('Product price:50 | QTY: 20',style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54
                ),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.orangeAccent,)),
                SizedBox(width: 60,),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,)),
              ],
            ),
          )

        ],
      ),
    );
  }
}
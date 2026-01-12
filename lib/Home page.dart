import 'package:flutter/material.dart';

class TourListScreen extends StatelessWidget {
  final List<String>Tours=['Sundarban','Bandarban','Sajek'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listview practice'),),
      body: ListView.builder(
        itemCount:Tours.length ,
          itemBuilder: (context,index){
          return ListTile(
             title: Text(Tours[index]),
            onTap: (){
               Navigator.push(context,
                 MaterialPageRoute(
                 //  builder: (BuildContext context) =>  MyPage(place:Tours[index]),
                     builder: (BuildContext context) => FavouriteButton(),
                 ),);
            },
          );

      }),
    );
  }
}
class MyPage extends StatelessWidget {
  final String place;
  const MyPage({super.key,  required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place),),
      body: Center(child: Text(place)),
    );
  }
}
class FavouriteButton extends StatefulWidget {
  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFav = !isFav;
        });
      },
    );
  }
}

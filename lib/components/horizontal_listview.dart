import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/cats/tshirt.png',
            image_caption: 'shirt',
          ),
          Category(
            image_location: 'images/cats/accessories.png',
            image_caption: 'accessories',
          ),
          Category(
            image_location: 'images/cats/jeans.png',
            image_caption: 'jeans',
          ),
          Category(
            image_location: 'images/cats/shoe.png',
            image_caption: 'shoe',
          ),
          Category(
            image_location: 'images/cats/informal.png',
            image_caption: 'informal',
          ),
          Category(
            image_location: 'images/cats/formal.png',
            image_caption: 'formal',
          ),
          Category(
            image_location: 'images/cats/dress.png',
            image_caption: 'dress',
          ),


        ]
      )

    );
  }
}

// Category class for categories
class Category extends StatelessWidget {

  final String image_location;
  final String image_caption;

  Category(
  {
    this.image_caption,
    this.image_location
});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2.0),
    child: InkWell(
      onTap: (){},
      child: Container(
        width: 100,
        child: ListTile(
          title: Image.asset(image_location, width: 100, height: 80,),
          subtitle: Container(
            alignment: Alignment.topCenter,
              child: Text(image_caption, style: new TextStyle(fontSize: 12.0))),
        ),
      )
    ));
  }
}


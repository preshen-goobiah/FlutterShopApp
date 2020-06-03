import 'package:flutter/material.dart';

class Products extends StatefulWidget
{
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products>
{
  // ignore: non_constant_identifier_names
  List product_list = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer1.jpeg',
      'old_price': 120,
      'price': 85,
    },
    {
      'name': 'Dress',
      'picture': 'images/products/dress1.jpeg',
      'old_price': 100,
      'price': 55,
    },
    {
      'name': 'Dress',
      'picture': 'images/products/dress2.jpeg',
      'old_price': 22,
      'price': 22,
    },

  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index){
            return Single_prod(
              prod_name: product_list[index]['name'],
              prod_picture: product_list[index]['picture'],
              prod_old_price: product_list[index]['old_price'],
              prod_price: product_list[index]['price'],
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod({
   this.prod_name,
   this.prod_picture,
   this.prod_old_price,
   this.prod_price
});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: prod_name,
        child: Material(
            child: InkWell(onTap: (){},
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                          prod_name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      title: Text("\R$prod_price", style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.w800
                      )),
                      subtitle: Text("\R$prod_old_price", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800, decoration: TextDecoration.lineThrough
                      )) ,
                    ),
                  ),
                  child: Image.asset(prod_picture,
                  fit: BoxFit.cover,),
                )
        )
      )
    ));
  }
}



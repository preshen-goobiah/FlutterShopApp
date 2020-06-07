import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  @override
  Widget build(BuildContext context)
  {
    List ProductsInCart = [

      {
        'name': 'Heels',
        'picture': 'images/products/hills1.jpeg',
        'old_price': 100,
        'price': 55,
        'size': "7",
        'color': "Red",
        "quantity": 1
      },
      {
        'name': 'Blazer - 2',
        'picture': 'images/products/blazer2.jpeg',
        'old_price': 100,
        'price': 55,
        'size': "XXL",
        'color': "Navy",
        "quantity": 1
      },
    ];
    return new ListView.builder(
        itemCount: ProductsInCart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: ProductsInCart[index]['name'],
            cart_prod_color:  ProductsInCart[index]['color'] ,
            cart_prod_qty:  ProductsInCart[index]['quantity'],
            cart_prod_size:  ProductsInCart[index]['size'],
            cart_prod_picture:  ProductsInCart[index]['picture'],
            cart_prod_price:  ProductsInCart[index]['price']

          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_color,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_qty,
    this.cart_prod_size
});



  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // ===== LEADING SECTION ====
        leading: new Image.asset(cart_prod_picture, width: 80, height: 80,),
       // ======= SUBTITLE SECTION=======
        title:  new Text(cart_prod_name),
        subtitle: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(0),
                 child: new Text("Size:"),
               ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(cart_prod_size, style: TextStyle(color: Colors.redAccent),),
                ),

                // ========= product color section =======
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                  child: new Text("Color:"),
                ),

                new Padding(padding: const EdgeInsets.all(4),
                child: new Text(cart_prod_color,  style: TextStyle(color: Colors.redAccent)),),


              ],
            ),

//        ========product price section========
          Container(
            alignment:  Alignment.topLeft,
              child: new Text('\$${cart_prod_price}', style:  TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),),

          ],
        ) ,
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: new Column(
            children: <Widget>[
              new IconButton(icon: Icon(Icons.arrow_drop_up,), onPressed: (){}),
              new Text(cart_prod_qty.toString()),
              new IconButton(icon: Icon(Icons.arrow_drop_down,), onPressed: (){})
            ],
          ),
        ),
      )
    );
  }

}

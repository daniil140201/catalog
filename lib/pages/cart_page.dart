import 'package:catalog/models/cart.dart';
import 'package:catalog/widgets/cart_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final cartData = Provider.of<CartDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Korzinka schastya'),
      ),
      body: cartData.cartItems.isEmpty
       ? Card(
        elevation:  5.0,
        margin: const EdgeInsets.all(30.0),
        child: Container(
          height: 100.0,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text('Korzina is empty'),
        ),
      )
          : Column(
        children: <Widget>[
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Ctoimost' + cartData.totalAmount.toStringAsFixed(2),
                style: TextStyle(fontSize: 20.0),
              ),
              MaterialButton(onPressed: (){
                cartData.clear();
              },
                color: Theme.of(context).primaryColor,
                child: Text('Buy'),
              ),
            ],
          ),
          Divider(),

          Expanded(child: CartItemList(cartData : cartData)),

        ],
      )
    );
  }
}

import 'package:coffeeapp/components/coffee_tile_cart.dart';
import 'package:coffeeapp/const.dart';
import 'package:coffeeapp/model/coffee_shop.dart';
import 'package:coffeeapp/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../components/My_button.dart';
import '../model/coffee.dart';
import '../services/email_service.dart';

class CartPage extends StatefulWidget {
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final EmailService emailService = EmailService();
  String items = "";

  void goToPaymentPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentPage(
                  onPaymentSuccess: () {},
                )));
  }

  double _calculateTotalPrice() {
    return Provider.of<CoffeeShope>(context, listen: false).userCart.fold(
          0.0,
          (total, coffee) => total += (coffee.price * coffee.quantity),
        );
  }

  int _calculateTotalItems() {
    return Provider.of<CoffeeShope>(context, listen: false).userCart.fold(
          0,
          (total, coffee) => total + coffee.quantity,
        );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: backgroundColor,
      ),
      body: Center(
          child: Consumer<CoffeeShope>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.userCart.length,
                itemBuilder: (context, index) {
                  Coffee eachCoffee = value.userCart[index];
                  items += '${eachCoffee.name} x ${eachCoffee.quantity}\n';
                  return CoffeeTileCart(
                      coffee: eachCoffee,
                      onPressed: () =>
                          Provider.of<CoffeeShope>(context, listen: false)
                              .removeFromCart(eachCoffee));
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(children: [
              Text(
                '   Total Quantity:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Spacer(),
              Text(
                '${_calculateTotalItems().toStringAsFixed(2)}   ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ]),
            Row(
              children: [
                Text(
                  '   Total Price:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  '\$${_calculateTotalPrice().toStringAsFixed(2)}   ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            MyButton(onTap: () => {goToPaymentPage(),_sendEmailOrder()}, text: 'Pay now '),
          ],
        ),
      )),
    );
  }

  void _sendEmailOrder() async {
    // String input = _phoneEmailController.text.trim();

    await emailService.sendEmail(
      emailService.email,
      'Your Order Detiles ',
      'order detiles: \n${items} \nTotal:\$ ${_calculateTotalPrice()}',
    );
    // Save the code locally or use another method to verify it later
  }
}

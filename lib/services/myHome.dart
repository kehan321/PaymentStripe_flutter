import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Tutorial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Merchant Name',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await makePayment();
              },
              child: const Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    final amount = _amountController.text;
    final merchantName = _nameController.text;

    if (amount.isEmpty || merchantName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter amount and merchant name')),
      );
      return;
    }

    try {
      paymentIntentData = await createPaymentIntent(amount, 'usd', merchantName);
      
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          merchantDisplayName: merchantName,
        ),
      );

      // Display the payment sheet
      await displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception: $e$s');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Payment successful!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Paid successfully")),
      );
    } on StripeException catch (e) {
      print('Stripe exception: $e');
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Payment cancelled"),
        ),
      );
    } catch (e) {
      print('General exception: $e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency, String merchantName) async {
    try {
      final Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
        'metadata[merchant_name]': merchantName, // Add metadata
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer sk_test_51Po1MkIvfCu4hzCZMZaNMiwzMqayhWyQwofyPvhzX3rRzklYtA4YPKTeYl48EZEAM8nbhSPJtYV0z7hQ34FqkH3D006QCezCZ2',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print('Create Intent response ===> ${response.body}');
      return jsonDecode(response.body);
    } catch (err) {
      print('Error creating payment intent: ${err.toString()}');
      rethrow;
    }
  }

  String calculateAmount(String amount) {
    final int a = int.parse(amount) * 100;
    return a.toString();
  }
}

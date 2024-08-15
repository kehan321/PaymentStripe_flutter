// import 'dart:convert';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;

// class StripeService {
//   static const String publishableKey = 'your_publishable_key';
//   static const String secretKey = 'your_secret_key';

//   static void init() {
//     Stripe.instance.applySettings(
//       settings: StripeSettings(
//         publishableKey: publishableKey,
//         merchantIdentifier: 'Test',
//         androidPayMode: 'test',
//       ),
//     );
//   }
// class StripeService {
//   static const String publishableKey = 'your_publishable_key';
//   static const String secretKey = 'your_secret_key';

//   static void init() {
//     Stripe.instance.applySettings(
//       settings: StripeSettings(
//         publishableKey: publishableKey,
//         merchantIdentifier: 'Test',
//         androidPayMode: 'test',
//       ),
//     );
//   }

//   static Future<void> processPayment({required int amount, required String currency}) async {
//     try {
//       // Create a payment intent
//       final paymentIntent = await createPaymentIntent(amount, currency);
      
//       // Create a payment method
//       final paymentMethod = await Stripe.instance.createPaymentMethod(
//         PaymentMethodParams.card(),
//       );

//       // Confirm the payment
//       final paymentResult = await Stripe.instance.confirmPayment(
//         paymentIntent['client_secret']!,
//         PaymentMethodParams.card(
//           paymentMethodId: paymentMethod.id,
//         ),
//       );

//       // Handle the payment result
//       if (paymentResult.status == PaymentIntentsStatus.succeeded) {
//         print('Payment successful');
//       } else {
//         print('Payment failed with status: ${paymentResult.status}');
//       }
//     } on StripeException catch (e) {
//       // Handle Stripe specific errors
//       print('Stripe error: ${e.error.message}');
//     } catch (e) {
//       // Handle other errors
//       print('Error: $e');
//     }
//   }

//   static Future<Map<String, dynamic>> createPaymentIntent(int amount, String import 'dart:convert';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;

// class StripeService {
//   static const String publishableKey = 'your_publishable_key';
//   static const String secretKey = 'your_secret_key';

//   static void init() {
//     Stripe.instance.applySettings(
//       settings: StripeSettings(
//         publishableKey: publishableKey,
//         merchantIdentifier: 'Test',
//         androidPayMode: 'test',
//       ),
//     );
//   }

//   static Future<void> processPayment({required int amount, required String currency}) async {
//     try {
//       // Create a payment intent
//       final paymentIntent = await createPaymentIntent(amount, currency);

//       // Create a payment method
//       final paymentMethod = await Stripe.instance.createPaymentMethod(
//         PaymentMethodParams.card(),
//       );

//       // Confirm the payment
//       final paymentResult = await Stripe.instance.confirmPayment(
//         paymentIntent['client_secret']!,
//         PaymentMethodParams.card(
//           paymentMethodId: paymentMethod.id,
//         ),
//       );

//       // Handle the payment result
//       if (paymentResult.status == PaymentIntentsStatus.succeeded) {
//         print('Payment successful');
//       } else {
//         print('Payment failed with status: ${paymentResult.status}');
//       }
//     } on StripeException catch (e) {
//       // Handle Stripe specific errors
//       print('Stripe error: ${e.error.message}');
//     } catch (e) {
//       // Handle other errors
//       print('Error: $e');
//     }
//   }

//   static Future<Map<String, dynamic>> createPaymentIntent(int amount, String currency) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $secretKey',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'amount': amount.toString(),
//           'currency': currency,
//           'payment_method_types[]': 'card',
//         },
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to create payment intent: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error creating payment intent: $e');
//     }
//   }
// }



//   static Future<Map<String, dynamic>> createPaymentIntent(int amount, String currency) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $secretKey',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'amount': amount.toString(),
//           'currency': currency,
//           'payment_method_types[]': 'card',
//         },
//       );
//       return jsonDecode(response.body);
//     } catch (e) {
//       throw Exception('Error creating payment intent: $e');
//     }}
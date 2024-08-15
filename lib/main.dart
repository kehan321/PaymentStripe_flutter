import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/services/myHome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the Stripe publishable key
  Stripe.publishableKey = 'pk_test_51Po1MkIvfCu4hzCZOUvAC4UmgbzIPwcNSqLODHqas4QXQaXPfW2wQmZs8JcVdIgc2S1YEf6fHNcShWUcPOkoOu0200cMsbYbzk';

  // Apply the settings
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(WebNovaApp());
}

class WebNovaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebNova MVP',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TransferScreen(),
    );
  }
}

class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  String fromCurrency = 'SAR';
  String toCurrency = 'EGP';
  String wallet = 'Vodafone Cash';
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebNova Transfer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount in $fromCurrency',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: fromCurrency,
              items: ['SAR', 'USD'].map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (val) {
                setState(() => fromCurrency = val!);
              },
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: wallet,
              items: [
                'Vodafone Cash',
                'InstaPay',
                'Etisalat Cash'
              ].map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (val) {
                setState(() => wallet = val!);
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                String amount = amountController.text;
                if (amount.isEmpty) return;

                double converted = double.tryParse(amount) ?? 0;
                // سعر صرف تجريبي SAR → EGP
                if (fromCurrency == 'SAR') converted *= 10.0;
                if (fromCurrency == 'USD') converted *= 50.0;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SuccessScreen(
                      fromCurrency: fromCurrency,
                      toCurrency: toCurrency,
                      amount: amount,
                      converted: converted,
                      wallet: wallet,
                    ),
                  ),
                );
              },
              child: Text('Confirm Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  final String fromCurrency;
  final String toCurrency;
  final String amount;
  final double converted;
  final String wallet;

  const SuccessScreen({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.converted,
    required this.wallet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 16),
            Text(
              'Transfer Successful!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('$amount $fromCurrency → ${converted.toStringAsFixed(2)} $toCurrency'),
            Text('Wallet: $wallet'),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

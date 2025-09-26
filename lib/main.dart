import 'package:flutter/material.dart';

void main() {
  runApp(WebNovaApp());
}

class WebNovaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebNova MVP',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AmountScreen(),
    );
  }
}

class AmountScreen extends StatelessWidget {
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebNova - تحويل الأموال')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'ادخل المبلغ (SAR/USD)'),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('اختار المحفظة'),
              items: [
                DropdownMenuItem(value: 'vodafone', child: Text('Vodafone Cash')),
                DropdownMenuItem(value: 'instapay', child: Text('InstaPay')),
                DropdownMenuItem(value: 'etisalat', child: Text('Etisalat Cash')),
              ],
              onChanged: (val) {},
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RecipientScreen()),
                );
              },
              child: Text('التالي'),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipientScreen extends StatelessWidget {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('بيانات المستلم')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'رقم المستلم'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SummaryScreen()),
                );
              },
              child: Text('التالي'),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double amountEGP = 1360; // مثال سعر الصرف
    double fee = amountEGP * 0.015;
    double total = amountEGP + fee;

    return Scaffold(
      appBar: AppBar(title: Text('ملخص العملية')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('المبلغ: $amountEGP EGP'),
            Text('الرسوم: $fee EGP'),
            Text('الإجمالي: $total EGP'),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => SuccessScreen()),
                  (route) => false,
                );
              },
              child: Text('تأكيد التحويل'),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text('تمت العملية بنجاح!', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const PayCalculatorApp());
}

class PayCalculatorApp extends StatelessWidget {
  const PayCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PayCalculatorScreen(),
    );
  }
}

class PayCalculatorScreen extends StatefulWidget {
  const PayCalculatorScreen({super.key});

  @override
  State<PayCalculatorScreen> createState() => _PayCalculatorScreenState();
}

class _PayCalculatorScreenState extends State<PayCalculatorScreen> {
  final TextEditingController _hoursWorkedController = TextEditingController();
  final TextEditingController _hourlyRateController = TextEditingController();

  double regularPay = 0;
  double overtimePay = 0;
  double totalPay = 0;
  double tax = 0;

  void calculatePay() {
    final double? hoursWorked = double.tryParse(_hoursWorkedController.text);
    final double? hourlyRate = double.tryParse(_hourlyRateController.text);

    if (hoursWorked == null || hourlyRate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid numbers for hours worked and hourly rate.'),
        ),
      );
      return;
    }

    setState(() {
      if (hoursWorked <= 40) {
        regularPay = hoursWorked * hourlyRate;
        overtimePay = 0;
      } else {
        regularPay = 40 * hourlyRate;
        overtimePay = (hoursWorked - 40) * hourlyRate * 1.5;
      }

      totalPay = regularPay + overtimePay;
      tax = totalPay * 0.18;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields for hours worked and hourly rate
            TextField(
              controller: _hoursWorkedController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Hours Worked',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _hourlyRateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Hourly Rate',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculatePay,
              child: const Text('Calculate Pay'),
            ),
            const SizedBox(height: 16),

            // Display results
            if (totalPay > 0) ...[
              Text('Regular Pay: \$${regularPay.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
              Text('Overtime Pay: \$${overtimePay.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
              Text('Total Pay (Before Tax): \$${totalPay.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
              Text('Tax: \$${tax.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
            ],

            const Spacer(),

            // Footer with full name and student ID
            const Text(
              'Maziar Hassanzadeh',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Student_ID: 301064337',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

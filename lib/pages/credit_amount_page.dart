import 'dart:math' as math;
import 'package:cred_assignment/widgets/page_title.dart';
import 'package:flutter/material.dart';

class CreditAmountPage extends StatefulWidget {
  final VoidCallback? onProceedToEmi;

  const CreditAmountPage({
    super.key,
    this.onProceedToEmi,
  });

  @override
  State<CreditAmountPage> createState() => _CreditAmountPageState();
}

class _CreditAmountPageState extends State<CreditAmountPage> {
  static const double maxAmount = 150000;
  double progressValue = 0.7;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.text = formattedAmount;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String get formattedAmount {
    final amount = (progressValue * maxAmount).round();
    return '₹${amount.toStringAsFixed(0)}';
  }

  void _updateAmount(String value) {
    final newAmount =
        int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    setState(() {
      progressValue = (newAmount / maxAmount).clamp(0.0, 1.0);
      _amountController.text = formattedAmount;
      _amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _amountController.text.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF0F1419),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.close, color: Colors.white),
      //     onPressed: () {},
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.help_outline, color: Colors.white),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height - 80,
        decoration: const BoxDecoration(
          color: Color(0xFF14191E),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              PageTitle(
                title: 'nikunj, how much do you need?',
                onTap: widget.onProceedToEmi,
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      final RenderBox box =
                          context.findRenderObject() as RenderBox;
                      final center = box.size.center(Offset.zero);
                      final position = details.localPosition;
                      final angle = math.atan2(
                        position.dy - center.dy,
                        position.dx - center.dx,
                      );
                      setState(() {
                        progressValue =
                            ((angle + math.pi) / (2 * math.pi)).clamp(0.0, 1.0);
                        _amountController.text = formattedAmount;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 250,
                          child: CircularProgressIndicator(
                            value: progressValue,
                            strokeWidth: 8,
                            backgroundColor: Colors.white.withOpacity(0.1),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFE8927C),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'credit amount',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                constraints: BoxConstraints(
                                  minWidth: 200,
                                ),
                              ),
                              textAlign: TextAlign.center,
                              onChanged: _updateAmount,
                            ),
                            Text(
                              '₹1.5M available',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'simply to remind, money will be credited within',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 80,
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: widget.onProceedToEmi,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF37469B),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Proceed to EMI option',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

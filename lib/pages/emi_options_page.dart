import 'package:cred_assignment/widgets/page_title.dart';
import 'package:flutter/material.dart';

class EmiOptionsPage extends StatefulWidget {
  final String selectedAmount;
  final Function(String)? onSelectEmi;

  const EmiOptionsPage({
    super.key,
    required this.selectedAmount,
    this.onSelectEmi,
  });

  @override
  State<EmiOptionsPage> createState() => _EmiOptionsPageState();
}

class _EmiOptionsPageState extends State<EmiOptionsPage> {
  int? selectedEmiOption;

  final List<Map<String, dynamic>> emiOptions = [
    {
      'months': 3,
      'amount': '₹50,000/mo',
      'interest': '12% p.a.',
    },
    {
      'months': 6,
      'amount': '₹25,000/mo',
      'interest': '13% p.a.',
    },
    {
      'months': 12,
      'amount': '₹12,500/mo',
      'interest': '14% p.a.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF14191E),
      // appBar: const CustomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height - 180,
        decoration: const BoxDecoration(
          color: Color(0xFF191928),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(
              title: 'how do you wish to repay?',
              onTap: () => widget.onSelectEmi?.call(
                '${emiOptions[selectedEmiOption ?? 0]['months']} months - ${emiOptions[selectedEmiOption ?? 0]['amount']}',
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'choose one of our recommended plans or create your own',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                itemCount: emiOptions.length + 1,
                itemBuilder: (context, index) {
                  if (index == emiOptions.length) {
                    return Container(
                      width: 170,
                      height: 120,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2630),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white24,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white24,
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Create your own plan',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  final option = emiOptions[index];
                  final isSelected = selectedEmiOption == index;

                  return Container(
                    width: 170,
                    height: 120,
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF37469B)
                          : const Color(0xFF1E2630),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.white24 : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isSelected)
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.white70,
                              size: 20,
                            ),
                          ),
                        Text(
                          option['amount'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'for ${option['months']} months',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          option['interest'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'See calculations',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 350),
            Container(
              height: 80,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  widget.onSelectEmi?.call(
                    '${emiOptions[selectedEmiOption ?? 0]['months']} months - ${emiOptions[selectedEmiOption ?? 0]['amount']}',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF37469B),
                  disabledBackgroundColor: const Color(0xFF37469B),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Select your bank',
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
    );
  }
}

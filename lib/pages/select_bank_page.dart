import 'package:cred_assignment/widgets/page_title.dart';
import 'package:flutter/material.dart';

class SelectBankPage extends StatefulWidget {
  final VoidCallback? onCollapse;

  const SelectBankPage({
    super.key,
    this.onCollapse,
  });

  @override
  State<SelectBankPage> createState() => _SelectBankPageState();
}

class _SelectBankPageState extends State<SelectBankPage> {
  int? selectedBank;

  final List<Map<String, String>> banks = [
    {
      'name': 'HDFC Bank',
      'account': '****1234',
      'type': 'Savings Account',
    },
    {
      'name': 'ICICI Bank',
      'account': '****5678',
      'type': 'Salary Account',
    },
    {
      'name': 'SBI Bank',
      'account': '****9012',
      'type': 'Current Account',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191928),
      // appBar: const CustomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height - 280,
        decoration: const BoxDecoration(
          color: Color(0xFF23283C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(
              title: 'where should we send the money?',
              onTap: () => widget.onCollapse?.call(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'amount will be credited to this bank account',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: banks.length,
                itemBuilder: (context, index) {
                  final bank = banks[index];
                  final isSelected = selectedBank == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBank = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF37469B)
                            : const Color(0xFF1E2630),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isSelected ? Colors.white24 : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                bank['name']![0],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bank['name']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  bank['account']!,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.white70,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: selectedBank != null ? () {} : null,
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
                  'Tap for 1-click KYC',
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

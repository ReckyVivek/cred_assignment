import 'package:cred_assignment/services/api_service.dart';
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
  late Future<Map<String, dynamic>> _emiDataFuture;

  final List<Color> cardColors = const [
    Color(0xFF41323C),
    Color(0xFF787391),
    Color(0xFF556987),
  ];

  @override
  void initState() {
    super.initState();
    _emiDataFuture = ApiService().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF14191E),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _emiDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final emiData = snapshot.data!['items'][1]['open_state']['body'];
          final emiOptions = (emiData['items'] as List)
              .map((item) => {
                    'months': item['duration'].split(' ')[0],
                    'amount': item['emi'],
                    'title': item['title'],
                    'subtitle': item['subtitle'],
                    'tag': item['tag'],
                  })
              .toList();

          return Container(
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
                  title: emiData['title'],
                  onTap: () => widget.onSelectEmi?.call(
                    selectedEmiOption != null
                        ? emiOptions[selectedEmiOption!]['title']
                        : '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    emiData['subtitle'],
                    style: const TextStyle(
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
                              Text(
                                emiData['footer'],
                                style: const TextStyle(
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

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedEmiOption = index;
                          });
                        },
                        child: Container(
                          width: 170,
                          height: 120,
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardColors[index],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.white24
                                  : Colors.transparent,
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
                                option['amount'] as String,
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
                              if (option['tag'] != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    option['tag'] as String,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  option['subtitle'] as String,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 320),
                Container(
                  height: 80,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: selectedEmiOption != null
                        ? () {
                            widget.onSelectEmi?.call(
                              emiOptions[selectedEmiOption!]['title'] as String,
                            );
                          }
                        : null,
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
                    child: Text(
                      snapshot.data!['items'][1]['cta_text'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

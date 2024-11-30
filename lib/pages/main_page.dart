import 'package:cred_assignment/widgets/closed_page_header.dart';
import 'package:cred_assignment/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'credit_amount_page.dart';
import 'emi_options_page.dart';
import 'select_bank_page.dart';
import '../models/stack_item.dart';
import '../controllers/stack_controller.dart';
import '../widgets/stack_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final StackController _controller = StackController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  void _setupStackItems(BuildContext context) {
    if (_isInitialized) return;
    _isInitialized = true;

    _controller.addItem(
      StackItem(
        expandedView: CreditAmountPage(
          onProceedToEmi: () => _controller.next(),
        ),
        collapsedView: const ClosedPageHeader(
          title: 'Credit amount',
          subtitle: '₹150,000',
          backgroundColor: Color(0xFF14191E),
        ),
        collapsedHeight: 100,
        expandedHeight: MediaQuery.of(context).size.height,
      ),
    );

    _controller.addItem(
      StackItem(
        expandedView: EmiOptionsPage(
          selectedAmount: '₹150,000',
          onSelectEmi: (emiOption) {
            _controller.next();
          },
        ),
        collapsedView: const ClosedPageHeader(
          title: 'EMI Option',
          subtitle: '12 months - ₹12,500/mo',
          backgroundColor: Color(0xFF191928),
        ),
        collapsedHeight: 100,
        expandedHeight: MediaQuery.of(context).size.height * 0.85,
      ),
    );

    _controller.addItem(
      StackItem(
        expandedView: SelectBankPage(
          onCollapse: () => _controller.back(),
        ),
        collapsedView: const ClosedPageHeader(
          title: 'Bank Account',
          subtitle: 'HDFC Bank ****1234',
          backgroundColor: Color(0xFF23283C),
        ),
        collapsedHeight: 100,
        expandedHeight: MediaQuery.of(context).size.height * 0.7,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _setupStackItems(context);
    return PopScope(
      canPop: !_controller.canGoBack,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _controller.back();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F1419),
        appBar: const CustomAppBar(),
        body: StackView(
          items: _controller.items,
          controller: _controller,
        ),
      ),
    );
  }
}

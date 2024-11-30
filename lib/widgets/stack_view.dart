import 'package:cred_assignment/controllers/stack_controller.dart';
import 'package:cred_assignment/models/stack_item.dart';
import 'package:flutter/material.dart';

class StackView extends StatefulWidget {
  final List<StackItem> items;
  final StackController controller;

  const StackView({
    super.key,
    required this.items,
    required this.controller,
  });

  @override
  State<StackView> createState() => _StackViewState();
}

class _StackViewState extends State<StackView> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        return Stack(
          children: List.generate(widget.items.length, (index) {
            final item = widget.items[index];
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              top: _calculateTopPosition(index),
              left: 0,
              right: 0,
              height: item.state == StackItemState.expanded
                  ? item.expandedHeight
                  : item.collapsedHeight,
              child: GestureDetector(
                onTap: () {
                  if (item.state == StackItemState.collapsed) {
                    while (widget.controller.currentIndex != index) {
                      if (index < widget.controller.currentIndex) {
                        widget.controller.back();
                      } else {
                        widget.controller.next();
                      }
                    }
                  }
                },
                child: item.state == StackItemState.expanded
                    ? item.expandedView
                    : item.collapsedView,
              ),
            );
          }),
        );
      },
    );
  }

  double _calculateTopPosition(int index) {
    double position = 0;
    for (var i = 0; i < index; i++) {
      position += widget.items[i].state == StackItemState.expanded
          ? widget.items[i].expandedHeight
          : widget.items[i].collapsedHeight;
    }
    return position;
  }
}

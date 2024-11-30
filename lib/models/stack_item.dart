import 'package:flutter/material.dart';

enum StackItemState { expanded, collapsed }

class StackItem {
  final Widget expandedView;
  final Widget collapsedView;
  StackItemState state;
  final double collapsedHeight;
  final double expandedHeight;

  StackItem({
    required this.expandedView,
    required this.collapsedView,
    this.state = StackItemState.collapsed,
    required this.collapsedHeight,
    required this.expandedHeight,
  });
}

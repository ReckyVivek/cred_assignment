import 'package:flutter/foundation.dart';
import '../models/stack_item.dart';

class StackController extends ChangeNotifier {
  final List<StackItem> _items = [];
  int _currentIndex = 0;

  List<StackItem> get items => _items;
  int get currentIndex => _currentIndex;

  void addItem(StackItem item) {
    if (_items.length < 4) {
      if (_items.isEmpty) {
        item.state = StackItemState.expanded;
      } else {
        item.state = StackItemState.collapsed;
      }
      _items.add(item);
      notifyListeners();
    }
  }

  void next() {
    if (_currentIndex < _items.length - 1) {
      _currentIndex++;
      _updateStates();
    }
  }

  void back() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _updateStates();
    }
  }

  void _updateStates() {
    for (var i = 0; i < _items.length; i++) {
      _items[i].state = i == _currentIndex
          ? StackItemState.expanded
          : StackItemState.collapsed;
    }
    notifyListeners();
  }

  bool get canGoBack => _currentIndex > 0;
}

import 'package:flutter/cupertino.dart';

class statusOrder extends ChangeNotifier {
  List<String> stages = [
    'chờ xác nhận',
    'đã xác nhận',
    'vận chuyển',
    'giao hàng thành công'
  ];
   clearorder(){
     _currentStage='chờ xác nhận';

     notifyListeners();
   }
  String _currentStage = 'chờ xác nhận';

  String get currentStage => _currentStage;
  int get currentIndex => stages.indexOf(_currentStage);

  void nextStage() {
    final currentIndex = stages.indexOf(_currentStage);
    if (currentIndex < stages.length - 1) {
      _currentStage = stages[currentIndex + 1];
      notifyListeners();
    }
  }
  void updateStage(String newStage) {
    if (stages.contains(newStage)) {
      _currentStage = newStage;

      notifyListeners();
    }
  }
}


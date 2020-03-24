import 'package:flutter/cupertino.dart';

class Counter with ChangeNotifier{
  int _count = 0;

  int get getCount => _count;

  void incrementCount(){
    _count+=2;
    notifyListeners();
  }
}
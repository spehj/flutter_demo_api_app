import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SelectedDateProvider extends ChangeNotifier{
  int? selectedDateIndex = 0;
  int? get index=>selectedDateIndex;

  void updateSelectedDateProvider(int newDateIndex){
    selectedDateIndex = newDateIndex;
    // print("NEW PROVIDER: $selectedDateIndex");
    notifyListeners();
  }
}
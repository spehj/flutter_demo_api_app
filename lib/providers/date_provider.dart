import 'package:flutter/cupertino.dart';

class SelectedDateProvider extends ChangeNotifier{
  /// Provider object to store value of selected day
  /// to update dates row. Active date has different color.
  int? selectedDateIndex = 0;
  int? get index=>selectedDateIndex;

  void updateSelectedDateProvider(int newDateIndex){
    // Method to update selectedDateIndex value
    selectedDateIndex = newDateIndex;
    // Notify all listeners for changes
    notifyListeners();
  }
}
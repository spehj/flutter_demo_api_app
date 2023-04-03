class Weeks {
  final int year;
  final Map<int, List<DateTime>> weeks;

  Weeks({
    required this.year,
  }): weeks = getWeeksInYear(year);



  static Map<int, List<DateTime>> getWeeksInYear(int year) {
    Map<int, List<DateTime>> weeks = {};
    DateTime date = DateTime(year, 1, 1);

    // Find the first Monday of the year
    while (date.weekday != DateTime.monday) {
      date = date.add(Duration(days: 1));
    }

    int weekIndex = 1;
    while (date.year == year) {
      // Find the dates in the current week
      List<DateTime> weekDates = [];
      for (int i = 0; i < 7; i++) {
        weekDates.add(date.add(Duration(days: i)));
      }
      weeks[weekIndex] = weekDates;

      // Move to the next week
      date = date.add(Duration(days: 7));
      weekIndex++;
    }

    return weeks;
  }
}

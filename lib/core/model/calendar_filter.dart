class CalendarFilter {
  final String name;
  final int numOfDays;
  
  const CalendarFilter._internal(this.numOfDays, this.name);

  static const week = CalendarFilter._internal(7, 'Week');
  static const month = CalendarFilter._internal(30, 'Month');
  static const year = CalendarFilter._internal(365, 'Year');

  static const list = [week, month, year];
}
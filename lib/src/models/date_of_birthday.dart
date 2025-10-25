class DateOfBirthday {
  final DateTime date;
  final int age;

  DateOfBirthday({
    required this.date,
    required this.age,
  });

  factory DateOfBirthday.frommap(Map<String, dynamic> map) => DateOfBirthday(
    date: DateTime.parse(map['date']),
    age: map['age'],
  );

  Map<String, dynamic> tomap() => {
    'date': date.toIso8601String(),
    'age': age,
  };

  factory DateOfBirthday.empty() => DateOfBirthday(date: DateTime(1), age: 0);
}

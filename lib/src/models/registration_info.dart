class RegistrationInfo {
  final DateTime date;
  final int age;

  RegistrationInfo({
    required this.date,
    required this.age,
  });

  factory RegistrationInfo.frommap(Map<String, dynamic> map) => RegistrationInfo(
    date: DateTime.parse(map['date']),
    age: map['age'],
  );

  Map<String, dynamic> tomap() => {
    'date': date.toIso8601String(),
    'age': age,
  };
}

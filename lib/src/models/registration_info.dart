class RegistrationInfo {
  final DateTime date;
  final int age;

  RegistrationInfo({
    required this.date,
    required this.age,
  });

  factory RegistrationInfo.fromMap(Map<String, dynamic> map) => RegistrationInfo(
    date: DateTime.parse(map['date']),
    age: map['age'],
  );

  Map<String, dynamic> toMap() => {
    'date': date.toIso8601String(),
    'age': age,
  };

  factory RegistrationInfo.empty() => RegistrationInfo(date: DateTime(2), age: 1);
}

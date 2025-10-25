class PersonIdentifier {
  final String name;
  final String? value;

  PersonIdentifier({
    required this.name,
    this.value,
  });

  factory PersonIdentifier.frommap(Map<String, dynamic> map) => PersonIdentifier(
    name: map['name'],
    value: map['value'],
  );

  Map<String, dynamic> tomap() => {
    'name': name,
    'value': value,
  };
}

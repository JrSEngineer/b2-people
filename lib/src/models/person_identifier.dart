class PersonIdentifier {
  final String name;

  PersonIdentifier({required this.name});

  factory PersonIdentifier.fromMap(Map<String, dynamic> map) => PersonIdentifier(name: map['name']);

  Map<String, dynamic> toMap() => {'name': name};
}

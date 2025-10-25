class PersonName {
  final String title;
  final String first;
  final String last;

  PersonName({
    required this.title,
    required this.first,
    required this.last,
  });

  factory PersonName.frommap(Map<String, dynamic> map) => PersonName(
    title: map['title'],
    first: map['first'],
    last: map['last'],
  );

  Map<String, dynamic> tomap() => {
    'title': title,
    'first': first,
    'last': last,
  };

  factory PersonName.empty() => PersonName(title: '', first: '', last: '');
}

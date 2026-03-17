class Suggestion {
  final String id;
  final String title;
  final String description;

  Suggestion({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
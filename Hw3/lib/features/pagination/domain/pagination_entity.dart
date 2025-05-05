class PostEntity {
  final int id;
  final String title;
  final String body;

  PostEntity({required this.id, required this.title, required this.body});

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      body: json['body'] ?? 'No Body',
    );
  }
}

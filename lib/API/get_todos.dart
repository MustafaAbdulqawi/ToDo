class GetTodos {
  final String id;
  final String image;
  final String title;
  final String description;
  final String priority;
  final String status;
  final String user;
  final String createdAt;
  final String updatedAt;
  GetTodos({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });
  factory GetTodos.fromJson(Map<String, dynamic> json) {
    return GetTodos(
      id: json['_id'],
      image: json['image'],
      title: json['title'],
      description: json['desc'],
      priority: json['priority'],
      status: json['status'],
      user: json['user'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

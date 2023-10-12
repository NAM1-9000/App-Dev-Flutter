class APIData {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  APIData(
      {required this.postId,
      required this.id,
      required this.name,
      required this.email,
      required this.body});

  factory APIData.fromJson(Map<String, dynamic> json) {
    return APIData(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body']);
  }
}

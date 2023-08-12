class Comment {
  final String body;
  final String ownerId;
  final String ownerName;
  final String ownerImage;
  final String project;
  final DateTime createdAt;

  Comment(
      {required this.body,
      required this.ownerId,
      required this.ownerName,
      required this.ownerImage,
      required this.project,
      required this.createdAt});

  factory Comment.fromJson(json) {
    return Comment(
      body: json['body'],
      ownerId: json['owner']['ownerId'],
      ownerName: json['owner']['username'],
      ownerImage: json['owner']['profileImage'],
      project: json['project'],
      createdAt: DateTime.parse(
        json['createdAt'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'body': body,
        'owner': ownerId,
        'project': project,
        'createdAt': createdAt,
      };
}

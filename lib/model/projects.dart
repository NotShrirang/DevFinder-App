class Project {
  final String url;
  final List tags;
  final String owner;
  final String title;
  final String description;
  dynamic featuredImage;
  dynamic demoLink;
  dynamic sourceLink;
  dynamic voteTotal;
  dynamic voteRatio;
  final DateTime createdAt;

  Project({
    required this.url,
    required this.tags,
    required this.owner,
    required this.title,
    required this.description,
    this.demoLink,
    this.sourceLink,
    this.voteTotal,
    this.featuredImage,
    this.voteRatio,
    required this.createdAt,
  });

  factory Project.fromJson(json) {
    // print(json);
    return Project(
      url: json['url'],
      tags: json['tags'],
      title: json['title'].toString(),
      owner: json['owner'],
      description: json['description'].toString(),
      demoLink: json['demoLink'].toString(),
      sourceLink: json['sourceLink'].toString(),
      voteTotal: json['voteTotal'].toString(),
      featuredImage: json['featuredImage'],
      voteRatio: json['voteRatio'].toString(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'tags': tags,
        'owner': owner,
        'title': title,
        'description': description,
        'demoLink': demoLink,
        'sourceLink': sourceLink,
        'voteTotal': voteTotal,
        'featuredImage': featuredImage,
        'voteRatio': voteRatio,
        'createdAt': createdAt,
      };
}

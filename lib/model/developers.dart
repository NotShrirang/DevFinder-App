class Developer {
  final String name;
  final String username;
  final String email;
  final String url;
  final List skills, messages_sent, messages_received;
  dynamic location;
  dynamic shortIntro;
  dynamic bio;
  dynamic profileImage;
  dynamic socialGithub;
  dynamic socialTwitter;
  dynamic socialYoutube;
  dynamic socialWebsite;
  dynamic socialHashnode;
  final DateTime createdAt;

  Developer({
    required this.name,
    required this.username,
    required this.email,
    required this.url,
    required this.skills,
    required this.messages_sent,
    required this.messages_received,
    this.location,
    this.shortIntro,
    this.bio,
    this.profileImage,
    this.socialGithub,
    this.socialTwitter,
    this.socialYoutube,
    this.socialWebsite,
    this.socialHashnode,
    required this.createdAt,
  });

  factory Developer.fromJson(json) {
    // // print(json);
    return Developer(
      url: json['url'],
      skills: json['skills'],
      messages_sent: json['messages_sent'],
      messages_received: json['messages_received'],
      name: json['name'],
      email: json['email'],
      username: json['username'].toString(),
      location: json['location'].toString(),
      shortIntro: json['shortIntro'].toString(),
      bio: json['bio'].toString(),
      profileImage: json['profileImage'],
      socialGithub: json['socialGithub'].toString(),
      socialTwitter: json['socialTwitter'].toString(),
      socialYoutube: json['socialYoutube'].toString(),
      socialWebsite: json['socialWebsite'].toString(),
      socialHashnode: json['socialHashnode'].toString(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'email': email,
        'url': url,
        'skills': skills,
        'messages_sent': messages_sent,
        'messages_received': messages_received,
        'location': location,
        'shortIntro': shortIntro,
        'bio': bio,
        'profileImage': profileImage,
        'socialGithub': socialGithub,
        'socialTwitter': socialTwitter,
        'socialYoutube': socialYoutube,
        'socialWebsite': socialWebsite,
        'socialHashnode': socialHashnode,
        'createdAt': createdAt,
      };
}

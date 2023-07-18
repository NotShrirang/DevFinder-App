class Developer {
  final String name;
  final String username;
  final String email;
  final String url;
  final List skills, messages_sent, messages_received;
  final String location;
  final String shortIntro;
  final String bio;
  final String profileImage;
  final String socialGithub;
  final String socialTwitter;
  final String socialYoutube;
  final String socialWebsite;
  final String socialHashnode;
  final DateTime createdAt;

  Developer({
    required this.name,
    required this.username,
    required this.email,
    required this.url,
    required this.skills,
    required this.messages_sent,
    required this.messages_received,
    required this.location,
    required this.shortIntro,
    required this.bio,
    required this.profileImage,
    required this.socialGithub,
    required this.socialTwitter,
    required this.socialYoutube,
    required this.socialWebsite,
    required this.socialHashnode,
    required this.createdAt,
  });

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      url: json['url'],
      skills: json['skills'],
      messages_sent: json['messages_sent'],
      messages_received: json['messages_received'],
      location: json['location'],
      shortIntro: json['shortIntro'],
      bio: json['bio'],
      profileImage: json['profileImage'],
      socialGithub: json['socialGithub'],
      socialTwitter: json['socialTwitter'],
      socialYoutube: json['socialYoutube'],
      socialWebsite: json['socialWebsite'],
      socialHashnode: json['socialHashnode'],
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

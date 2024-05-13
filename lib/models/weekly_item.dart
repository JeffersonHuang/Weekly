class WeeklyItem {
  int number;
  String title;
  String link;

  WeeklyItem({required this.number, required this.title, required this.link});

  factory WeeklyItem.fromJson(Map<String, dynamic> json) {
    return WeeklyItem(
      number: json['number'],
      title: json['title'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'title': title,
      'link': link,
    };
  }

  @override
  String toString() {
    return 'WeeklyItem{number: $number, title: $title, link: $link}';
  }
}

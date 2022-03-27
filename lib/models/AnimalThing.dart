class AnimalThing {
    final String image;
    final int answer;
    final List<dynamic> choices;

  AnimalThing({
    required this.image,
    required this.answer,
    required this.choices
  });

  factory AnimalThing.fromJson(Map<String, dynamic> json) {
    return AnimalThing(
        image: json['image_url'],
        answer: json['answer'],
        choices: json['choice_list'],
    );
  }
}

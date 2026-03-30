import 'dart:convert';

class FlashCard {
  final String question;
  final String answer;

  FlashCard({required this.question, required this.answer});

  Map<String, dynamic> toJson() => {'question': question, 'answer': answer};

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(question: json['question'], answer: json['answer']);
  }
}

class Deck {
  String name;
  String emoji;
  List<String> gradientColors; // hex strings
  List<FlashCard> cards;

  Deck({
    required this.name,
    required this.emoji,
    required this.gradientColors,
    required this.cards,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'emoji': emoji,
    'gradientColors': gradientColors,
    'cards': cards.map((c) => c.toJson()).toList(),
  };

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
      name: json['name'],
      emoji: json['emoji'],
      gradientColors: List<String>.from(json['gradientColors']),
      cards: (json['cards'] as List).map((c) => FlashCard.fromJson(c)).toList(),
    );
  }

  // encode a list of decks to a JSON string
  static String encodeList(List<Deck> decks) {
    return jsonEncode(decks.map((d) => d.toJson()).toList());
  }

  // decode a JSON string back to a list of decks
  static List<Deck> decodeList(String source) {
    final list = jsonDecode(source) as List;
    return list.map((d) => Deck.fromJson(d)).toList();
  }
}

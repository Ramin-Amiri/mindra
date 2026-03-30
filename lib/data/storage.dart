import 'package:shared_preferences/shared_preferences.dart';
import '../models/deck.dart';
import '../data/sample_decks.dart';

class Storage {
  static const _key = 'mindra_decks';

  // load decks from local storage, or return sample decks on first run
  static Future<List<Deck>> loadDecks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);

    if (raw == null) {
      // first time: save sample decks and return them
      await saveDecks(sampleDecks);
      return sampleDecks;
    }

    return Deck.decodeList(raw);
  }

  // save the full deck list to local storage
  static Future<void> saveDecks(List<Deck> decks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, Deck.encodeList(decks));
  }
}

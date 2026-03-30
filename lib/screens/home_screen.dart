import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../data/storage.dart';
import '../widgets/deck_card.dart';
import 'quiz_screen.dart';
import 'add_deck_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Deck> _decks = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDecks();
  }

  Future<void> _loadDecks() async {
    final decks = await Storage.loadDecks();
    setState(() {
      _decks = decks;
      _loading = false;
    });
  }

  void _openQuiz(Deck deck) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen(deck: deck)),
    );
  }

  void _deleteDeck(int index) async {
    final deck = _decks[index];
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Deck'),
        content: Text('Delete "${deck.name}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _decks.removeAt(index));
      await Storage.saveDecks(_decks);
    }
  }

  void _addDeck() async {
    // navigate to add deck screen, wait for result
    final newDeck = await Navigator.push<Deck>(
      context,
      MaterialPageRoute(builder: (_) => const AddDeckScreen()),
    );

    if (newDeck != null) {
      setState(() => _decks.add(newDeck));
      await Storage.saveDecks(_decks);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: Column(
        children: [
          // purple header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 24,
              right: 24,
              bottom: 20,
            ),
            decoration: const BoxDecoration(color: Color(0xFF5C33CC)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Learner!',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'My FlashCards',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // deck grid
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Decks',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF332659),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 165 / 160,
                            ),
                            itemCount: _decks.length,
                            itemBuilder: (context, i) {
                              return DeckCard(
                                deck: _decks[i],
                                onTap: () => _openQuiz(_decks[i]),
                                onLongPress: () => _deleteDeck(i),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF5E54), Color(0xFFFF8C33)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF5E54).withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _addDeck,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 28),
        ),
      ),
    );
  }
}

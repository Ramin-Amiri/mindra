import 'package:flutter/material.dart';
import '../models/deck.dart';

class AddDeckScreen extends StatefulWidget {
  const AddDeckScreen({super.key});

  @override
  State<AddDeckScreen> createState() => _AddDeckScreenState();
}

class _AddDeckScreenState extends State<AddDeckScreen> {
  final _nameController = TextEditingController();
  final List<Map<String, TextEditingController>> _cardControllers = [];
  String _selectedEmoji = '📚';

  final _emojis = ['📚', '💡', '🎯', '🧠', '🎨', '🎵', '💻', '⚡'];
  final _gradients = [
    ['#FF5E54', '#FF8C33'],
    ['#33B3F2', '#66D9B2'],
    ['#8C4DF2', '#D966F2'],
    ['#FFBF33', '#FF8C59'],
    ['#FF6B9D', '#C44DFF'],
    ['#00C9A7', '#00B4D8'],
  ];
  int _selectedGradient = 0;

  @override
  void initState() {
    super.initState();
    // start with 2 empty card slots
    _addCardSlot();
    _addCardSlot();
  }

  void _addCardSlot() {
    _cardControllers.add({
      'q': TextEditingController(),
      'a': TextEditingController(),
    });
    setState(() {});
  }

  void _removeCardSlot(int i) {
    _cardControllers[i]['q']!.dispose();
    _cardControllers[i]['a']!.dispose();
    _cardControllers.removeAt(i);
    setState(() {});
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Give your deck a name')),
      );
      return;
    }

    // collect non-empty cards
    final cards = <FlashCard>[];
    for (var c in _cardControllers) {
      final q = c['q']!.text.trim();
      final a = c['a']!.text.trim();
      if (q.isNotEmpty && a.isNotEmpty) {
        cards.add(FlashCard(question: q, answer: a));
      }
    }

    if (cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one card')),
      );
      return;
    }

    final deck = Deck(
      name: name,
      emoji: _selectedEmoji,
      gradientColors: _gradients[_selectedGradient],
      cards: cards,
    );

    Navigator.pop(context, deck);
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (var c in _cardControllers) {
      c['q']!.dispose();
      c['a']!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: Column(
        children: [
          // app bar
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 8,
              right: 16,
              bottom: 16,
            ),
            decoration: const BoxDecoration(color: Color(0xFF5C33CC)),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const Text(
                  'Create Deck',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _save,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // form
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // deck name
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Deck name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // emoji picker
                const Text(
                  'Pick an icon',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF332659),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  children: _emojis.map((e) {
                    final selected = e == _selectedEmoji;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedEmoji = e),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF8C4DF2).withValues(alpha: 0.15)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: selected
                              ? Border.all(color: const Color(0xFF8C4DF2), width: 2)
                              : null,
                        ),
                        child: Center(
                          child: Text(e, style: const TextStyle(fontSize: 24)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // color picker
                const Text(
                  'Pick a color',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF332659),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  children: List.generate(_gradients.length, (i) {
                    final selected = i == _selectedGradient;
                    final colors = _gradients[i];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedGradient = i),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: colors
                                .map((c) => Color(
                                    int.parse('FF${c.replaceFirst('#', '')}',
                                        radix: 16)))
                                .toList(),
                          ),
                          border: selected
                              ? Border.all(color: Colors.white, width: 3)
                              : null,
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 8,
                                  )
                                ]
                              : null,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // cards section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cards',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF332659),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _addCardSlot,
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                ...List.generate(_cardControllers.length, (i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Card ${i + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8C4DF2),
                              ),
                            ),
                            const Spacer(),
                            if (_cardControllers.length > 1)
                              GestureDetector(
                                onTap: () => _removeCardSlot(i),
                                child: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _cardControllers[i]['q'],
                          decoration: const InputDecoration(
                            hintText: 'Question',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _cardControllers[i]['a'],
                          decoration: const InputDecoration(
                            hintText: 'Answer',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

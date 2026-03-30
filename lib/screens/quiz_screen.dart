import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../widgets/flip_card.dart';

class QuizScreen extends StatefulWidget {
  final Deck deck;

  const QuizScreen({super.key, required this.deck});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _current = 0;
  bool _flipped = false;

  void _flip() => setState(() => _flipped = !_flipped);

  void _next() {
    if (_current < widget.deck.cards.length - 1) {
      setState(() {
        _current++;
        _flipped = false;
      });
    }
  }

  void _prev() {
    if (_current > 0) {
      setState(() {
        _current--;
        _flipped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.deck.cards[_current];
    final total = widget.deck.cards.length;
    final progress = (_current + 1) / total;

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
              right: 24,
              bottom: 16,
            ),
            decoration: const BoxDecoration(color: Color(0xFF5C33CC)),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                Text(
                  widget.deck.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // progress bar
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card ${_current + 1} of $total',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF736699),
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE0DBEF),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFFF8C33),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // flashcard
          Expanded(
            child: GestureDetector(
              onTap: _flip,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: FlipCard(
                    flipped: _flipped,
                    front: _buildCardFace(
                      label: 'QUESTION',
                      text: card.question,
                      hint: 'Tap to reveal answer',
                      color: const Color(0xFF8C4DF2),
                    ),
                    back: _buildCardFace(
                      label: 'ANSWER',
                      text: card.answer,
                      hint: 'Tap to see question',
                      color: const Color(0xFFFF8C33),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // navigation buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 48, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // prev
                _navButton(
                  icon: Icons.arrow_back,
                  onTap: _prev,
                  enabled: _current > 0,
                ),
                const SizedBox(width: 24),
                // flip
                GestureDetector(
                  onTap: _flip,
                  child: Container(
                    width: 140,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8C4DF2), Color(0xFF5C33CC)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8C4DF2).withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Flip Card',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // next
                _navButton(
                  icon: Icons.arrow_forward,
                  onTap: _next,
                  enabled: _current < total - 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool enabled,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEBE8F5),
        ),
        child: Icon(
          icon,
          color: enabled
              ? const Color(0xFF8C4DF2)
              : const Color(0xFF8C4DF2).withValues(alpha: 0.3),
          size: 22,
        ),
      ),
    );
  }

  Widget _buildCardFace({
    required String label,
    required String text,
    required String hint,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5C33CC).withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF332659),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            hint,
            style: const TextStyle(fontSize: 13, color: Color(0xFFA69BBF)),
          ),
        ],
      ),
    );
  }
}

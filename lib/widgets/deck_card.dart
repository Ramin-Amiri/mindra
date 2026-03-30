import 'package:flutter/material.dart';
import '../models/deck.dart';

// converts a hex string like "#FF5E54" to a Color
Color hexToColor(String hex) {
  hex = hex.replaceFirst('#', '');
  return Color(int.parse('FF$hex', radix: 16));
}

class DeckCard extends StatelessWidget {
  final Deck deck;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const DeckCard({
    super.key,
    required this.deck,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: deck.gradientColors.map(hexToColor).toList(),
          ),
          boxShadow: [
            BoxShadow(
              color: hexToColor(deck.gradientColors[0]).withValues(alpha:0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(deck.emoji, style: const TextStyle(fontSize: 36)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deck.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${deck.cards.length} cards',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha:0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

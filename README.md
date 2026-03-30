# Mindra — Flashcard Quiz App

A clean, minimal flashcard app built with Flutter for smarter learning. Create custom decks, study with animated flip cards, and track your progress through any subject.

---

## Screenshots

> _Add screenshots here once the app is running on your device._

---

## Features

- **Preloaded decks** — Mathematics, Science, Geography, and History included out of the box
- **Create custom decks** — Pick a name, icon, and color theme, then add as many cards as you need
- **Animated flip cards** — Smooth 3D flip animation to reveal answers
- **Progress bar** — Shows your position as you move through a deck
- **Persistent storage** — Decks are saved locally using `shared_preferences`
- **Delete decks** — Long-press any deck card to remove it

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3 |
| Language | Dart |
| Local storage | `shared_preferences` |
| SVG rendering | `flutter_svg` |
| State management | `setState` (built-in) |

---

## Project Structure

```
lib/
├── data/
│   ├── sample_decks.dart     # Preloaded deck content
│   └── storage.dart          # SharedPreferences read/write
├── models/
│   └── deck.dart             # Deck & FlashCard models with JSON serialization
├── screens/
│   ├── home_screen.dart      # Deck grid + FAB to add decks
│   ├── add_deck_screen.dart  # Form to create a new deck
│   └── quiz_screen.dart      # Card-by-card quiz with flip animation
└── widgets/
    ├── deck_card.dart         # Gradient card tile shown in the grid
    └── flip_card.dart         # Animated 3D flip card widget
```

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.1.0`
- Dart `>=3.1.0`
- An emulator or physical device

### Installation

```bash
# Clone the repository
git clone https://github.com/Rxm1nAmiri/mindra.git

# Navigate into the project
cd mindra

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## How to Use

| Action | How |
|---|---|
| Open a deck | Tap any deck card |
| Flip a card | Tap the card or press **Flip Card** |
| Next / previous card | Use the arrow buttons |
| Create a deck | Tap the **+** button on the home screen |
| Delete a deck | **Long-press** a deck card → confirm |

---

## Dependencies

```yaml
dependencies:
  flutter_svg: ^2.0.10+1
  shared_preferences: ^2.2.2
```

---

## License

This project is open source and available under the [MIT License](LICENSE).

---

<p align="center">Built with Flutter</p>

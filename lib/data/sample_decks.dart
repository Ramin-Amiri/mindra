import '../models/deck.dart';

// sample decks that come with the app
final List<Deck> sampleDecks = [
  Deck(
    name: 'Mathematics',
    emoji: '🧮',
    gradientColors: ['#FF5E54', '#FF8C33'],
    cards: [
      FlashCard(question: 'What is the value of π (pi)?', answer: '3.14159'),
      FlashCard(question: 'What is 12 × 12?', answer: '144'),
      FlashCard(question: 'Square root of 169?', answer: '13'),
      FlashCard(question: 'What is 2⁸?', answer: '256'),
      FlashCard(question: 'What is the sum of angles in a triangle?', answer: '180°'),
    ],
  ),
  Deck(
    name: 'Science',
    emoji: '🔬',
    gradientColors: ['#33B3F2', '#66D9B2'],
    cards: [
      FlashCard(question: 'What gas do plants absorb?', answer: 'Carbon dioxide (CO₂)'),
      FlashCard(question: 'What is H₂O?', answer: 'Water'),
      FlashCard(question: 'Speed of light?', answer: '299,792,458 m/s'),
      FlashCard(question: 'Hardest natural substance?', answer: 'Diamond'),
    ],
  ),
  Deck(
    name: 'Geography',
    emoji: '🌍',
    gradientColors: ['#8C4DF2', '#D966F2'],
    cards: [
      FlashCard(question: 'Capital of Turkey?', answer: 'Ankara'),
      FlashCard(question: 'Largest ocean?', answer: 'Pacific Ocean'),
      FlashCard(question: 'Longest river in the world?', answer: 'Nile River'),
      FlashCard(question: 'Which continent has the most countries?', answer: 'Africa (54 countries)'),
    ],
  ),
  Deck(
    name: 'History',
    emoji: '📜',
    gradientColors: ['#FFBF33', '#FF8C59'],
    cards: [
      FlashCard(question: 'Who discovered America?', answer: 'Christopher Columbus (1492)'),
      FlashCard(question: 'When did WW2 end?', answer: '1945'),
      FlashCard(question: 'Who built the pyramids?', answer: 'Ancient Egyptians'),
    ],
  ),
];

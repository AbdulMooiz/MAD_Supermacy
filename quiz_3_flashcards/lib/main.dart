import 'package:flutter/material.dart';

void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Flutter Flashcards',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const FlashcardHome(),
    );
  }
}

class FlashcardHome extends StatefulWidget {
  const FlashcardHome({super.key});

  @override
  State<FlashcardHome> createState() => _FlashcardHomeState();
}

class _FlashcardHomeState extends State<FlashcardHome> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<Map<String, String>> _flashcards = [
    {
      'question': 'What is the difference between Future, Stream, and async* in Dart?',
      'answer':
      'A Future represents a single async result; Stream represents multiple async events; async* allows yielding values over time.'
    },
    {
      'question': 'Explain the widget tree, element tree, and render tree in Flutter.',
      'answer':
      'Widget tree defines configuration; element tree manages widget instances; render tree handles layout and painting.'
    },
    {
      'question': 'What is the purpose of the BuildContext in Flutter?',
      'answer':
      'It provides location in the widget tree, used to access theme, navigation, and ancestor widgets.'
    },
    {
      'question': 'How does Flutter achieve 60 FPS performance?',
      'answer':
      'By using its own rendering engine (Skia), avoiding OEM widgets, batching GPU frames efficiently, and reducing layout passes.'
    },
    {
      'question': 'What is the difference between setState() and provider-based state management?',
      'answer':
      'setState() rebuilds a single widget, while Provider enables reactive rebuilding across the widget tree using ChangeNotifier.'
    },
  ];

  int learnedCount = 0;

  Future<void> _refreshCards() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      learnedCount = 0;
      _flashcards = [
        {
          'question': 'Explain how keys help in Flutter widget rebuilding.',
          'answer':
          'Keys preserve widget identity when the tree rebuilds, helping Flutter decide whether to reuse or recreate widgets.'
        },
        {
          'question': 'What is the difference between hot reload and hot restart?',
          'answer':
          'Hot reload preserves state and updates code; hot restart resets state and restarts the app entirely.'
        },
        {
          'question': 'How does Flutter handle layout constraints?',
          'answer':
          'Widgets receive parent constraints, decide their own size, and pass constraints to children recursively.'
        },
        {
          'question': 'What are mixins in Dart, and when are they used?',
          'answer':
          'Mixins let you reuse code in multiple classes without inheritance using the “with” keyword.'
        },
        {
          'question': 'What is an InheritedWidget used for?',
          'answer':
          'It passes data efficiently down the widget tree to descendants without requiring explicit parameters.'
        },
      ];
    });
  }

  void _addNewCard() {
    final newCard = {
      'question': 'What are isolates in Dart and why are they needed?',
      'answer':
      'Isolates are independent threads with separate memory, used for parallel computation without shared state.'
    };
    _flashcards.insert(0, newCard);
    _listKey.currentState?.insertItem(0);
  }

  void _removeCard(int index) {
    final removedCard = _flashcards.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => _buildCard(removedCard, index, animation),
      duration: const Duration(milliseconds: 300),
    );
    setState(() => learnedCount++);
  }

  Widget _buildCard(Map<String, String> card, int index,
      [Animation<double>? animation]) {
    return SizeTransition(
      sizeFactor: animation ?? const AlwaysStoppedAnimation(1),
      child: FlashcardWidget(
        question: card['question']!,
        answer: card['answer']!,
        onDismissed: () => _removeCard(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewCard,
        icon: const Icon(Icons.add),
        label: const Text('Add Question'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCards,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              expandedHeight: 130,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  '$learnedCount of ${_flashcards.length + learnedCount} learned',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: AnimatedList(
                key: _listKey,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                initialItemCount: _flashcards.length,
                itemBuilder: (context, index, animation) {
                  final card = _flashcards[index];
                  return _buildCard(card, index, animation);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlashcardWidget extends StatefulWidget {
  final String question;
  final String answer;
  final VoidCallback onDismissed;

  const FlashcardWidget({
    super.key,
    required this.question,
    required this.answer,
    required this.onDismissed,
  });

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => widget.onDismissed(),
      background: Container(
        color: Colors.green.shade400,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          title: Text(
            widget.question,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: showAnswer
              ? Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(widget.answer,
                style: const TextStyle(color: Colors.deepPurple)),
          )
              : null,
          onTap: () => setState(() => showAnswer = !showAnswer),
        ),
      ),
    );
  }
}

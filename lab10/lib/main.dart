import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Library',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const BookLibrary(),
    );
  }
}

class Book {
  final String title;
  final String author;
  final double price;
  final String emoji;
  final Color color;

  Book({
    required this.title,
    required this.author,
    required this.price,
    required this.emoji,
    required this.color,
  });
}

class BookLibrary extends StatefulWidget {
  const BookLibrary({super.key});

  @override
  State<BookLibrary> createState() => _BookLibraryState();
}

class _BookLibraryState extends State<BookLibrary> {
  bool _isGridView = true;

  final List<Book> books = [
    Book(title: 'The Alchemist', author: 'Paulo Coelho', price: 15.0, emoji: '📘', color: Colors.teal.shade100),
    Book(title: 'Atomic Habits', author: 'James Clear', price: 18.5, emoji: '📗', color: Colors.green.shade100),
    Book(title: '1984', author: 'George Orwell', price: 12.0, emoji: '📙', color: Colors.orange.shade100),
    Book(title: 'Rich Dad Poor Dad', author: 'R. Kiyosaki', price: 14.5, emoji: '📕', color: Colors.red.shade100),
    Book(title: 'Think & Grow Rich', author: 'Napoleon Hill', price: 16.0, emoji: '📔', color: Colors.blue.shade100),
    Book(title: 'Harry Potter', author: 'J.K. Rowling', price: 25.0, emoji: '📖', color: Colors.purple.shade100),
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverSafeArea(
            sliver: SliverAppBar(
              title: Text('Book Library'),
              floating: true,
              snap: true,
              actions: [
                Icon(Icons.search),
                SizedBox(width: 16),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Books',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
                    onPressed: () {
                      setState(() {
                        _isGridView = !_isGridView;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          if (_isGridView)
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final book = books[index];
                  return Card(
                    color: book.color,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(book.emoji, style: const TextStyle(fontSize: 40)),
                          const SizedBox(height: 8),
                          Text(book.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(book.author,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black54)),
                          const SizedBox(height: 8),
                          Text(
                            '\$${book.price}',
                            style: const TextStyle(
                                color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: books.length,
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final book = books[index];
                  return Card(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: book.color,
                        child: Text(book.emoji),
                      ),
                      title: Text(book.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(book.author),
                      trailing: Text(
                        '\$${book.price}',
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
                childCount: books.length,
              ),
            ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recommended Books',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: books.map((book) {
                  return Card(
                    color: book.color,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(book.emoji, style: const TextStyle(fontSize: 24)),
                          const SizedBox(height: 8),
                          Text(
                            book.title.split(' ').first,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}

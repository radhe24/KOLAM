import 'package:flutter/material.dart';

class FullArticleScreen extends StatelessWidget {
  final Map<String, dynamic> article; // Article data passed from ExploreHeritageScreen

  const FullArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title'] ?? 'Article'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (article['thumbnailUrl'] != null)
                Image.network(article['thumbnailUrl']!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 100),
                ),
              const SizedBox(height: 16.0),
              Text(
                article['title'] ?? 'No Title',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                article['full_content'] ?? article['blurb'] ?? 'No content available.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              const Text("Placeholder for full article content, YouTube videos, image sliders, etc.",
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

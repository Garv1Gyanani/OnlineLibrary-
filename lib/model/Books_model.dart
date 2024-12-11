class Author {
  final String name;
  final int birthYear;
  final int deathYear;

  Author({required this.name, required this.birthYear, required this.deathYear});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'] ?? 'Unknown Author', // Default if name is missing
      birthYear: json['birth_year'] ?? 0, // Default to 0 if birth year is null
      deathYear: json['death_year'] ?? 0, // Default to 0 if death year is null
    );
  }
}

class Book {
  final int id;
  final String title;
  final List<Author> authors;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final bool copyright;
  final int downloadCount;
  final String? image; // Optional field for image URL
  final String? htmlLink; // Link to the HTML format
  final String? epubLink; // Link to the EPUB format

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.downloadCount,
    this.image,
    this.htmlLink,
    this.epubLink,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    // Use the null-aware operator to handle null values safely
    var authorsJson = json['authors'] as List? ?? [];
    List<Author> authorsList = authorsJson.map((i) => Author.fromJson(i)).toList();

    var formats = json['formats'] as Map<String, dynamic>? ?? {};

    return Book(
      id: json['id'] is int ? json['id'] : 0, // Provide a default value if null
      title: json['title'] ?? 'Unknown Title',
      authors: authorsList,
      subjects: List<String>.from(json['subjects'] ?? []),
      bookshelves: List<String>.from(json['bookshelves'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      copyright: json['copyright'] ?? false,
      downloadCount: json['download_count'] is int ? json['download_count'] : 0, // Default to 0 if null
      image: formats['image/jpeg'] as String?, // Assuming you want the JPEG image URL
      htmlLink: formats['text/html'] as String?, // HTML format link
      epubLink: formats['application/epub+zip'] as String?, // EPUB format link
    );
  }
}

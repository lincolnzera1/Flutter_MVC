import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Biblia {
  Book book;
  Chapter chapter;
  List<Verses> verses;
  
  Biblia({
    required this.book,
    required this.chapter,
    required this.verses,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'book': book.toMap(),
      'chapter': chapter.toMap(),
      'verses': verses.map((x) => x.toMap()).toList(),
    };
  }

  factory Biblia.fromMap(Map<String, dynamic> map) {
    return Biblia(
      book: Book.fromMap(map['book'] as Map<String, dynamic>),
      chapter: Chapter.fromMap(map['chapter'] as Map<String, dynamic>),
      verses: List<Verses>.from(
        (map['verses'] as List<dynamic>).map<Verses>(
          (x) => Verses.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Biblia.fromJson(String source) =>
      Biblia.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Book {
  Abreviacao abbrev;
  String name;
  String author;
  String group;
  String version;
  Book({
    required this.abbrev,
    required this.name,
    required this.author,
    required this.group,
    required this.version,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'abbrev': abbrev.toMap(),
      'name': name,
      'author': author,
      'group': group,
      'version': version,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      abbrev: Abreviacao.fromMap(map['abbrev'] as Map<String, dynamic>),
      name: map['name'] as String,
      author: map['author'] as String,
      group: map['group'] as String,
      version: map['version'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Abreviacao {
  String pt;
  String en;
  Abreviacao({
    required this.pt,
    required this.en,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pt': pt,
      'en': en,
    };
  }

  factory Abreviacao.fromMap(Map<String, dynamic> map) {
    return Abreviacao(
      pt: map['pt'] as String,
      en: map['en'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Abreviacao.fromJson(String source) =>
      Abreviacao.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Chapter {
  int number;
  int verses;
  Chapter({
    required this.number,
    required this.verses,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'verses': verses,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      number: map['number'] as int,
      verses: map['verses'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Verses {
  int number;
  String text;
  Verses({
    required this.number,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'text': text,
    };
  }

  factory Verses.fromMap(Map<String, dynamic> map) {
    return Verses(
      number: map['number'] as int,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Verses.fromJson(String source) =>
      Verses.fromMap(json.decode(source) as Map<String, dynamic>);
}

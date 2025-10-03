class Word {
  final String text;
  final int difficulty;
  final String category;

  Word(this.text, this.difficulty, this.category);

  @override
  String toString() {
    return toCsv();
  }

  String toCsv() {
    return '$text,$category,$difficulty';
  }
}

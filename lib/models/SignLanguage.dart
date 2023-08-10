class SignLanguageSymbol {
  final String title;
  final String image;
  final String description;

  SignLanguageSymbol({
    required this.title,
    required this.image,
    required this.description,
  });
}

class SignLanguageSymbolList {
  List<SignLanguageSymbol> symbols = [
    SignLanguageSymbol(
      title: "I",
      image: "assets/img/IinSign.jpg",
      description: "Gesture of the letter 'I' in sign language.",
    ),
    SignLanguageSymbol(
      title: "Want",
      image: "assets/img/wantinSign.jpg",
      description: "Gesture of the word 'Want' in sign language.",
    ),
    SignLanguageSymbol(
      title: "to",
      image: "assets/img/toinSign.jpg",
      description: "Gesture of the word 'to' in sign language.",
    ),
    SignLanguageSymbol(
      title: "Say",
      image: "assets/img/sayinSign.jpg",
      description: "Gesture of the word 'Say' in sign language.",
    ),
    SignLanguageSymbol(
      title: "Thank",
      image: "assets/img/thankinSign.jpg",
      description: "Gesture of the word 'Thank' in sign language.",
    ),
    SignLanguageSymbol(
      title: "You",
      image: "assets/img/youinSign.jpg",
      description: "Gesture of the word 'You' in sign language.",
    ),
  ];

  // Add more symbols as needed

  List<SignLanguageSymbol> searchSymbols(String sentence) {
    final SignLanguageSymbolList symbolList = SignLanguageSymbolList();

    List<SignLanguageSymbol> matchedSymbols = [];

    List<String> words = sentence.split(' ');
    for (String word in words) {
      for (SignLanguageSymbol symbol in symbolList.symbols) {
        if (symbol.title.toLowerCase() == word.toLowerCase()) {
          matchedSymbols.add(symbol);
          break;
        }
      }
    }

    return matchedSymbols;
  }
}

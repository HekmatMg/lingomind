class ErrorCorrection {
  const ErrorCorrection({
    required this.originalText,
    required this.explanation,
    required this.correctedText,
  });

  final String originalText;
  final String explanation;
  final String correctedText;
}

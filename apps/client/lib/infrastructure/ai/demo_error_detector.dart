import '../../domain/entities/error_correction.dart';
import '../../domain/services/error_detector.dart';

class DemoErrorDetector implements ErrorDetector {
  const DemoErrorDetector();

  @override
  ErrorCorrection? detect(String learnerText) {
    final text = learnerText.trim();
    final lower = text.toLowerCase();

    if (lower.contains('i goed')) {
      return ErrorCorrection(
        originalText: text,
        explanation: 'کارت خوب بود، ولی به‌جای goed باید بگی went.',
        correctedText: text.replaceFirst(RegExp(r'(?i)goed'), 'went'),
      );
    }

    if (lower.contains('he go')) {
      return ErrorCorrection(
        originalText: text,
        explanation: 'برای he در زمان حال ساده، فعل go باید به goes تبدیل شود.',
        correctedText: text.replaceFirst(RegExp(r'(?i)he go'), 'He goes'),
      );
    }

    return null;
  }
}

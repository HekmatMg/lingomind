import '../entities/error_correction.dart';

abstract interface class ErrorDetector {
  ErrorCorrection? detect(String learnerText);
}

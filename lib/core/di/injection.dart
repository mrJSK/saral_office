// lib/core/di/injection.dart
import 'package:get_it/get_it.dart';
import 'package:saral_office/core/database/services/isar_service.dart';
import 'package:saral_office/features/payment_authority/services/payment_authority_pdf_service.dart';
import 'package:saral_office/features/payment_authority/providers/payment_authority_provider.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Isar
  getIt.registerSingleton<IsarService>(IsarService());
  await getIt<IsarService>().initialize();

  // PDF service
  getIt.registerLazySingleton<PaymentAuthorityPdfService>(
    () => PaymentAuthorityPdfService(),
  );
}

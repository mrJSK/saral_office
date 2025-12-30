import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ========================================================================
  // SAVE TI DOCUMENT RAW DATA ONLY
  // ========================================================================
  Future<void> saveTIDocumentData(Map<String, dynamic> documentData) async {
    try {
      // Add metadata
      final dataToSave = {
        ...documentData,
        'documentType': 'TI_DOCUMENT',
        'createdAt': FieldValue.serverTimestamp(),
        'appVersion': '1.0.0',
        'platform': Platform.operatingSystem,
      };

      // Save ONLY raw data to Firestore (NO PDF)
      final docRef = await _firestore
          .collection('ti_documents')
          .add(dataToSave);

      debugPrint('✅ TI Document data saved to Firebase: ${docRef.id}');
    } catch (e) {
      debugPrint('❌ Error saving TI Document to Firebase: $e');
      // Don't throw - we don't want to block PDF generation
    }
  }

  // ========================================================================
  // SAVE PAYMENT AUTHORITY RAW DATA ONLY
  // ========================================================================
  Future<void> savePaymentAuthorityData(
    Map<String, dynamic> authorityData,
  ) async {
    try {
      // Add metadata
      final dataToSave = {
        ...authorityData,
        'documentType': 'PAYMENT_AUTHORITY',
        'createdAt': FieldValue.serverTimestamp(),
        'appVersion': '1.0.0',
        'platform': Platform.operatingSystem,
      };

      // Save ONLY raw data to Firestore (NO PDF)
      final docRef = await _firestore
          .collection('payment_authorities')
          .add(dataToSave);

      debugPrint('✅ Payment Authority data saved to Firebase: ${docRef.id}');
    } catch (e) {
      debugPrint('❌ Error saving Payment Authority to Firebase: $e');
      // Don't throw - we don't want to block PDF generation
    }
  }

  // ========================================================================
  // ANALYTICS: Get document counts
  // ========================================================================
  Future<Map<String, int>> getDocumentCounts() async {
    try {
      final tiCount = await _firestore.collection('ti_documents').count().get();

      final paCount = await _firestore
          .collection('payment_authorities')
          .count()
          .get();

      return {
        'tiDocuments': tiCount.count ?? 0,
        'paymentAuthorities': paCount.count ?? 0,
      };
    } catch (e) {
      debugPrint('Error getting document counts: $e');
      return {'tiDocuments': 0, 'paymentAuthorities': 0};
    }
  }
}

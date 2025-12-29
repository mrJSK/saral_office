import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ========================================================================
  // SAVE TI DOCUMENT
  // ========================================================================
  Future<void> saveTIDocument(
    Map<String, dynamic> documentData,
    File? pdfFile,
  ) async {
    try {
      // Add metadata
      final dataToSave = {
        ...documentData,
        'documentType': 'TI_DOCUMENT',
        'createdAt': FieldValue.serverTimestamp(),
        'appVersion': '1.0.0', // Update with your app version
        'platform': Platform.operatingSystem,
      };

      // Save to Firestore
      final docRef = await _firestore
          .collection('ti_documents')
          .add(dataToSave);

      debugPrint('✅ TI Document saved to Firebase: ${docRef.id}');

      // Optional: Upload PDF to Firebase Storage
      // if (pdfFile != null) {
      //   await _uploadPdfToStorage(docRef.id, pdfFile, 'ti_documents');
      // }
    } catch (e) {
      debugPrint('❌ Error saving TI Document to Firebase: $e');
      // Don't throw - we don't want to block PDF generation
      // Just log the error
    }
  }

  // ========================================================================
  // SAVE PAYMENT AUTHORITY
  // ========================================================================
  Future<void> savePaymentAuthority(
    Map<String, dynamic> authorityData,
    File? pdfFile,
  ) async {
    try {
      // Add metadata
      final dataToSave = {
        ...authorityData,
        'documentType': 'PAYMENT_AUTHORITY',
        'createdAt': FieldValue.serverTimestamp(),
        'appVersion': '1.0.0', // Update with your app version
        'platform': Platform.operatingSystem,
      };

      // Save to Firestore
      final docRef = await _firestore
          .collection('payment_authorities')
          .add(dataToSave);

      debugPrint('✅ Payment Authority saved to Firebase: ${docRef.id}');

      // Optional: Upload PDF to Firebase Storage
      // if (pdfFile != null) {
      //   await _uploadPdfToStorage(docRef.id, pdfFile, 'payment_authorities');
      // }
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

  // ========================================================================
  // OPTIONAL: Upload PDF to Firebase Storage
  // ========================================================================
  // Future<String?> _uploadPdfToStorage(
  //   String documentId,
  //   File pdfFile,
  //   String collection,
  // ) async {
  //   try {
  //     final storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('$collection/$documentId.pdf');
  //
  //     await storageRef.putFile(pdfFile);
  //     final downloadUrl = await storageRef.getDownloadURL();
  //
  //     // Update Firestore document with PDF URL
  //     await _firestore
  //         .collection(collection)
  //         .doc(documentId)
  //         .update({'pdfUrl': downloadUrl});
  //
  //     debugPrint('✅ PDF uploaded to Storage: $downloadUrl');
  //     return downloadUrl;
  //   } catch (e) {
  //     debugPrint('❌ Error uploading PDF: $e');
  //     return null;
  //   }
  // }
}

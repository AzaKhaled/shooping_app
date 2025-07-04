import 'package:fruits_hub/core/services/data_service.dart';

class FakeDatabaseService implements DatabaseService {
  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    // لا تفعل شيء مؤقتًا
    return;
  }

  @override
  Future<Map<String, dynamic>> getData({
    required String path,
    required String docuementId,
  }) async {
    // ترجع بيانات وهمية
    return {
      'name': 'Test User',
      'email': 'test@example.com',
      'uId': docuementId,
    };
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String docuementId,
  }) async {
    return false; // اعتبر المستخدم مش موجود دايمًا
  }
}

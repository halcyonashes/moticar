import 'package:chopper/chopper.dart';
import 'package:moticar/services/supabase_service.dart';
import 'dart:convert';

class SupabaseRepository {
  final SupabaseService _service;

  SupabaseRepository({required ChopperClient client})
      : _service = SupabaseService.create(client);

  Future<List<Map<String, dynamic>>> fetchDashboardData() async {
    final response = await _service.getDashboardData();

    if (response.isSuccessful) {
      final data = jsonDecode(response.bodyString) as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception("Failed to fetch dashboard data");
    }
  }
}

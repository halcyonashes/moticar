// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SupabaseService extends SupabaseService {
  _$SupabaseService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SupabaseService;

  @override
  Future<Response<dynamic>> getDashboardData() {
    final Uri $url = Uri.parse('dashboard_data');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}

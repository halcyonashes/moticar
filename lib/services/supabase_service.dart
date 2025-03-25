import 'package:chopper/chopper.dart';

// 🔹 Define the base API service
part 'supabase_service.chopper.dart';

@ChopperApi()
abstract class SupabaseService extends ChopperService {
  @GET(path: 'dashboard')
  Future<Response> getDashboardData();

  static SupabaseService create([ChopperClient? client]) =>
      _$SupabaseService(client);
}

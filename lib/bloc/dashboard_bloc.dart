import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/supabase_repository.dart';

// 🔹 Events
abstract class DashboardEvent {}

class FetchDashboardData extends DashboardEvent {}

// 🔹 States
abstract class DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<Map<String, dynamic>> data;
  DashboardLoaded({required this.data});
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}

// 🔹 Bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final SupabaseRepository repository;

  DashboardBloc({required this.repository}) : super(DashboardLoading()) {
    on<FetchDashboardData>((event, emit) async {
      try {
        final data = await repository.fetchDashboardData();
        emit(DashboardLoaded(data: data));
      } catch (e) {
        emit(DashboardError("Failed to load dashboard data"));
      }
    });
  }
}

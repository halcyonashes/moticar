import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state is DashboardError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<DashboardBloc>().add(FetchDashboardData());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is DashboardLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Pie Chart Analysis
                  const Text("Pie Chart Analysis", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(value: 40, color: Colors.blue, title: "40%"),
                          PieChartSectionData(value: 30, color: Colors.green, title: "30%"),
                          PieChartSectionData(value: 20, color: Colors.red, title: "20%"),
                          PieChartSectionData(value: 10, color: Colors.yellow, title: "10%"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 Recent Tabs
                  const Text("Recent Tabs", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Chip(label: Text("Tab 1")),
                        const SizedBox(width: 10),
                        Chip(label: Text("Tab 2")),
                        const SizedBox(width: 10),
                        Chip(label: Text("Tab 3")),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 Tracker
                  const Text("Tracker", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(value: 0.6),

                  const SizedBox(height: 20),

                  // 🔹 Upload Documents Section (Horizontal Scrollable)
                  const Text("Upload Documents", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _documentCard("Document 1"),
                        _documentCard("Document 2"),
                        _documentCard("Document 3"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 Get Advice Section
                  const Text("Get Advice", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to advice page using GoRouter
                    },
                    child: const Text("Get Expert Advice"),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(child: Text('No data available'));
      },
    );
  }

  Widget _documentCard(String title) {
    return Card(
      margin: const EdgeInsets.only(right: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(title),
      ),
    );
  }
} 
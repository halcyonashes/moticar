import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import 'analysis_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardContent(),
    const AnalysisScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch dashboard data when the screen is initialized
    context.read<DashboardBloc>().add(FetchDashboardData());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigate to notifications using GoRouter
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _screens[_selectedIndex],
      floatingActionButton: _selectedIndex == 0 ? FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add new item using GoRouter
        },
        child: const Icon(Icons.add),
      ) : null,
    );
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return "Home";
      case 1:
        return "Analysis";
      case 2:
        return "Settings";
      default:
        return "Dashboard";
    }
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state is DashboardError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is DashboardLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Display dashboard data
                Expanded(
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final item = state.data[index];
                      return Card(
                        child: ListTile(
                          title: Text(item['title'] ?? 'No Title'),
                          subtitle: Text(item['description'] ?? 'No Description'),
                          trailing: Text(item['value']?.toString() ?? ''),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('No data available'));
      },
    );
  }
}

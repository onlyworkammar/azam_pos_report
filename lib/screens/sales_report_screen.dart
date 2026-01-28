import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../providers/sales_provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';
import 'sales_data_tab.dart';
import 'sales_graph_tab.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<DateTime> _selectedDates = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Fetch sales on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SalesProvider>(context, listen: false).fetchSales();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showDatePickerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Dates'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: SfDateRangePicker(
            selectionMode: DateRangePickerSelectionMode.multiple,
            initialSelectedDates: _selectedDates,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              setState(() {
                _selectedDates = args.value as List<DateTime>;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedDates = [];
              });
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final salesProvider = Provider.of<SalesProvider>(context, listen: false);
              salesProvider.setSelectedDates(_selectedDates);
              await salesProvider.fetchSales(dates: _selectedDates);
              if (mounted) {
                navigator.pop();
              }
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showDatePickerDialog,
            tooltip: 'Filter by Date',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final navigator = Navigator.of(context);
              await Provider.of<AuthProvider>(context, listen: false).logout();
              if (mounted) {
                navigator.pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
            tooltip: 'Logout',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.table_chart), text: 'Data'),
            Tab(icon: Icon(Icons.show_chart), text: 'Graph'),
          ],
        ),
      ),
      body: Column(
        children: [
          Consumer<SalesProvider>(
            builder: (context, salesProvider, _) {
              if (salesProvider.selectedDates.isNotEmpty) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.blue.shade50,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Selected: ${salesProvider.selectedDates.length} date(s)',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          salesProvider.setSelectedDates([]);
                          salesProvider.fetchSales();
                        },
                        child: const Text('Clear Filter'),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                SalesDataTab(),
                SalesGraphTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

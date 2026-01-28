import 'package:flutter/foundation.dart';
import '../models/sale.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class SalesProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();

  List<Sale> _sales = [];
  bool _isLoading = false;
  String? _error;
  DateTime? _startDate;
  DateTime? _endDate;
  List<DateTime> _selectedDates = [];

  List<Sale> get sales => _sales;
  bool get isLoading => _isLoading;
  String? get error => _error;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  List<DateTime> get selectedDates => _selectedDates;

  double get totalSales => _sales.fold(0.0, (sum, sale) => sum + sale.totalAmount);
  int get totalItems => _sales.fold(0, (sum, sale) => sum + sale.items.length);
  int get totalQuantity => _sales.fold(0, (sum, sale) => sum + sale.items.fold(0, (itemSum, item) => itemSum + item.quantity));

  Future<void> fetchSales({List<DateTime>? dates}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Not authenticated');
      }

      String? startDateStr;
      String? endDateStr;

      if (dates != null && dates.isNotEmpty) {
        _selectedDates = dates;
        if (dates.length == 1) {
          final date = dates.first;
          startDateStr = DateTime(date.year, date.month, date.day, 0, 0, 0).toIso8601String();
          endDateStr = DateTime(date.year, date.month, date.day, 23, 59, 59).toIso8601String();
        } else {
          dates.sort();
          startDateStr = DateTime(dates.first.year, dates.first.month, dates.first.day, 0, 0, 0).toIso8601String();
          endDateStr = DateTime(dates.last.year, dates.last.month, dates.last.day, 23, 59, 59).toIso8601String();
        }
      } else if (_startDate != null && _endDate != null) {
        startDateStr = DateTime(_startDate!.year, _startDate!.month, _startDate!.day, 0, 0, 0).toIso8601String();
        endDateStr = DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59).toIso8601String();
      }

      final response = await _apiService.getSalesWithItems(
        startDate: startDateStr,
        endDate: endDateStr,
        accessToken: token,
      );

      _sales = response.sales;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _sales = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setDateRange(DateTime? start, DateTime? end) {
    _startDate = start;
    _endDate = end;
    notifyListeners();
  }

  void setSelectedDates(List<DateTime> dates) {
    _selectedDates = dates;
    notifyListeners();
  }
}

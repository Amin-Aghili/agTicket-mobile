import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/company_model.dart';
import '../services/company_service.dart';

/// State اصلی
class CompanyState {
  final List<CompanyModel> companies;
  final bool isLoading;
  final String? error;

  CompanyState({
    this.companies = const [],
    this.isLoading = false,
    this.error,
  });

  CompanyState copyWith({
    List<CompanyModel>? companies,
    bool? isLoading,
    String? error,
  }) {
    return CompanyState(
      companies: companies ?? this.companies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier
class CompanyNotifier extends StateNotifier<CompanyState> {
  final CompanyService service;

  CompanyNotifier(this.service) : super(CompanyState());

  /// گرفتن همه شرکت‌ها
  Future<void> loadCompanies() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await service.getAllCompanies();
      state = state.copyWith(companies: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// اضافه کردن
  Future<void> addCompany(CompanyModel company) async {
    try {
      await service.insertCompany(company);
      await loadCompanies();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// آپدیت
  Future<void> updateCompany(CompanyModel company) async {
    try {
      await service.updateCompany(company);
      await loadCompanies();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// حذف
  Future<void> deleteCompany(int id) async {
    try {
      await service.deleteCompany(id);
      await loadCompanies();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// گوش دادن real-time
  void subscribeCompanies() {
    service.subscribeToCompanies().listen((data) {
      state = state.copyWith(companies: data);
    });
  }
}

/// Provider اصلی
final companyProvider = StateNotifierProvider<CompanyNotifier, CompanyState>(
  (ref) => CompanyNotifier(CompanyService()),
);

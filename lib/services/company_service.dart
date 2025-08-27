import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/company_model.dart';

class CompanyService {
  final SupabaseClient _client = Supabase.instance.client;

  // Reading a company by ID
  Future<CompanyModel> getCompany(int companyId) async {
    try {
      final response = await _client
          .from('company')
          .select('*')
          .eq('id', companyId)
          .single();
      return CompanyModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch company: $e');
    }
  }

  // Reading all companies
  Future<List<CompanyModel>> getAllCompanies() async {
    try {
      final response = await _client.from('company').select('*');
      print('Raw response: $response');
      return (response as List<dynamic>)
          .map((json) => CompanyModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch companies: $e');
    }
  }

  // Inserting a new company
  Future<void> insertCompany(CompanyModel company) async {
    try {
      await _client.from('company').insert(company.toJson());
    } catch (e) {
      throw Exception('Failed to insert company: $e');
    }
  }

  // Updating a company
  Future<void> updateCompany(CompanyModel company) async {
    try {
      await _client
          .from('company')
          .update(company.toJson())
          .eq('id', company.id);
    } catch (e) {
      throw Exception('Failed to update company: $e');
    }
  }

  // Deleting a company
  Future<void> deleteCompany(int companyId) async {
    try {
      await _client.from('company').delete().eq('id', companyId);
    } catch (e) {
      throw Exception('Failed to delete company: $e');
    }
  }

  // Real-time subscription for company changes
  Stream<List<CompanyModel>> subscribeToCompanies() {
    try {
      return _client.from('company').stream(primaryKey: ['id']).map(
          (data) => data.map(CompanyModel.fromJson).toList());
    } catch (e) {
      throw Exception('Failed to subscribe to companies: $e');
    }
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase;

  AuthService(this.supabase);

  Future<AuthResponse> signUp(String email, String password) {
    return supabase.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signInWithPassword(String email, String password) {
    return supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() {
    return supabase.auth.signOut();
  }

  Stream<AuthState> get onAuthStateChange => supabase.auth.onAuthStateChange;

  User? get currentUser => supabase.auth.currentUser;
}

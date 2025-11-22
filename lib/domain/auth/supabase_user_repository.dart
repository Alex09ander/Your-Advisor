import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:your_advisor/domain/auth/user_repository.dart';

final class SupabaseUserRepository implements UserRepository {
  @override
  String? get userId => Supabase.instance.client.auth.currentUser?.id;

  @override
  bool get isLoggedIn => userId != null;
}

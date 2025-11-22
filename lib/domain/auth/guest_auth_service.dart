import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class GuestAuthService {
  GuestAuthService(this._supabase);

  final SupabaseClient _supabase;
  final _storage = const FlutterSecureStorage();
  final _uuid = const Uuid();

  static const _kGuestIdKey = 'guest_id';
  static const _kGuestEmailKey = 'guest_email';
  static const _kGuestPasswordKey = 'guest_password';

  Future<void> ensureSignedInAsGuest() async {
    final session = _supabase.auth.currentSession;
    if (session != null) return;

    var guestId = await _storage.read(key: _kGuestIdKey);
    var email = await _storage.read(key: _kGuestEmailKey);
    var password = await _storage.read(key: _kGuestPasswordKey);

    if (guestId == null || email == null || password == null) {
      guestId = _uuid.v4();
      email = 'guest_$guestId@jbxgzhiiiifqqiwoqmzr.supabase.co';
      password = _uuid.v4();

      await _storage.write(key: _kGuestIdKey, value: guestId);
      await _storage.write(key: _kGuestEmailKey, value: email);
      await _storage.write(key: _kGuestPasswordKey, value: password);

      await _signUpGuest(email, password);
    }

    await _signInGuest(email, password);
  }

  Future<void> _signUpGuest(String email, String password) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: null, // brak weryfikacji maila dla guestów
      );
    } on AuthException catch (e) {
      // Jeśli user już istnieje (np. po resetach bazy) – ignoruj
      if (!e.message.toLowerCase().contains('already registered')) {
        rethrow;
      }
    }
  }

  Future<void> _signInGuest(String email, String password) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    // UWAGA: nie kasujemy guest_*, żeby po ponownym wejściu zalogować się tym samym gościem
  }

  Future<void> resetGuestOnThisDevice() async {
    await _supabase.auth.signOut();
    await _storage.delete(key: _kGuestIdKey);
    await _storage.delete(key: _kGuestEmailKey);
    await _storage.delete(key: _kGuestPasswordKey);
  }
}

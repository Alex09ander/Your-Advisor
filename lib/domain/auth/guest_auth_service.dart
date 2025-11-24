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
    // 1. Jeśli już mamy sesję – nic nie rób
    if (_supabase.auth.currentSession != null) {
      return;
    }

    // 2. Spróbuj zalogować się istniejącymi danymi
    var guestId = await _storage.read(key: _kGuestIdKey);
    var email = await _storage.read(key: _kGuestEmailKey);
    var password = await _storage.read(key: _kGuestPasswordKey);

    if (guestId != null && email != null && password != null) {
      try {
        await _signInGuest(email, password);
        return;
      } on AuthException catch (e) {
        // np. invalid_credentials, user_deleted, email_not_confirmed, itp.
        print('Guest sign-in failed, resetting guest: ${e.code} ${e.message}');
        await resetGuestOnThisDevice();
      }
    }

    // 3. Jeśli nie było danych lub się nie udało – twórz nowego gościa
    await _createNewGuestAndSignIn();
  }

  Future<void> _createNewGuestAndSignIn() async {
    final guestId = _uuid.v4();
    final email = 'guest_$guestId@jbxgzhiiiifqqiwoqmzr.supabase.co';
    final password = _uuid.v4();

    await _storage.write(key: _kGuestIdKey, value: guestId);
    await _storage.write(key: _kGuestEmailKey, value: email);
    await _storage.write(key: _kGuestPasswordKey, value: password);

    try {
      await _signUpGuest(email, password);
    } on AuthException catch (e) {
      // Jeśli email już istnieje – spoko, zaraz spróbujemy się zalogować
      if (!e.message.toLowerCase().contains('already registered')) {
        print('Guest sign-up failed: ${e.code} ${e.message}');
        rethrow;
      }
    }

    // 4. Zawsze spróbuj jawnie się zalogować
    await _signInGuest(email, password);
  }

  Future<void> _signUpGuest(String email, String password) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: null, // i tak nie klikamy maila
    );
  }

  Future<void> _signInGuest(String email, String password) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    // Nie kasujemy guest_* — dalej zostaje ten sam gość na tym buildzie
  }

  Future<void> resetGuestOnThisDevice() async {
    await _supabase.auth.signOut();
    await _storage.delete(key: _kGuestIdKey);
    await _storage.delete(key: _kGuestEmailKey);
    await _storage.delete(key: _kGuestPasswordKey);
  }
}

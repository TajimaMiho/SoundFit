import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/models/account.dart';
import 'package:mycloud/models/account_state.dart';
import 'package:mycloud/provider/login_provider.dart';

final accountProvider =
    StateNotifierProvider<AccountStateProvider, AccountState>(
  (ref) => AccountStateProvider(
    ref,
  ),
);

class AccountStateProvider extends StateNotifier<AccountState> {
  AccountStateProvider(this._reader) : super(const AccountState()) {
    init();
  }

  final fireAccountService = FireAccountService();

  Future<void> init() async {
    String email = _reader.watch(loginProvider).user.email;
    final fetchedAccount = await fireAccountService.fetchAccount(email);
    state = state.copyWith(account: fetchedAccount);
  }

  void updateAccount(Account account) {
    state = state.copyWith(account: account);
  }

  final StateNotifierProviderRef _reader;
}

// StreamProviderを使うことでStreamも扱うことができる
// ※ autoDisposeを付けることで自動的に値をリセットできます

class FireAccountService {
  final _fireStore = FirebaseFirestore.instance;

  Future<Account> fetchAccount(String email) async {
    final document =
        await FirebaseFirestore.instance.collection('users').doc(email).get();

    return const Account().copyWith(name: document['name']);
  }
}

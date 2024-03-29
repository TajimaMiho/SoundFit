import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/provider/login/login_provider.dart';
import 'package:mycloud/provider/login/login_state.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginState loginState = ref.watch(loginProvider);
    final String infoText = loginState.infoText;
    final String email = loginState.email;
    final String name = loginState.name;
    final String password = loginState.password;
    final bool isLoginMode = loginState.isLoginMode;

    return Scaffold(
      appBar: AppBar(
          shape:
              Border(bottom: BorderSide(color: Styles.primaryColor, width: 3)),
          backgroundColor: Colors.white,
          title: isLoginMode
              ? const Text('Sigin in',
                  style: TextStyle(color: Styles.primaryColor))
              : const Text('Create an account.',
                  style: TextStyle(color: Styles.primaryColor))),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'email address'),
                onChanged: (String value) {
                  ref.read(loginProvider.notifier).changeEmail(value);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (String value) {
                  ref.read(loginProvider.notifier).changePassword(value);
                },
              ),
              isLoginMode
                  ? const SizedBox()
                  : TextFormField(
                      decoration: const InputDecoration(labelText: 'Your name'),
                      onChanged: (String value) {
                        ref.read(loginProvider.notifier).changeName(value);
                      },
                    ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(infoText),
              ),
              isLoginMode
                  ? SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        child: const Text('Sign in'),
                        onPressed: () async {
                          try {
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            await auth.signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            if (FirebaseAuth.instance.currentUser == null) {
                              return;
                            }
                            ref.read(loginProvider.notifier).changeUser(
                                FirebaseAuth.instance.currentUser!.email!);
                          } catch (e) {
                            ref.read(loginProvider.notifier).changeInfoText(
                                "Sign-in failed.：${e.toString()}");
                          }
                        },
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text('Create an account.'),
                        onPressed: () async {
                          try {
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            final result =
                                await auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            ref
                                .read(loginProvider.notifier)
                                .changeUser(result.user!.email!);

                            if (result.user == null) {
                              return;
                            }
                            // サブコレクション内にドキュメント作成
                            await FirebaseFirestore.instance
                                .collection('users') // コレクションID
                                .doc(result.user
                                    ?.email) // ドキュメントID << usersコレクション内のドキュメント
                                .set({
                              'name': name.isEmpty ? 'unnamed' : name,
                              'date': DateTime.now().toLocal().toIso8601String()
                            });
                            ref.read(loginProvider.notifier).changeMode(true);
                            ref.read(loginProvider.notifier).changeName('');
                          } catch (e) {
                            ref.read(loginProvider.notifier).changeInfoText(
                                "Sign-in failed.: ${e.toString()}");
                          }
                        },
                      ),
                    ),
              const SizedBox(
                height: 8,
              ),
              //新規登録を消したい場合は以下を消す！
              isLoginMode
                  ? SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          child: const Text('Create an account.'),
                          onPressed: () async {
                            ref.read(loginProvider.notifier).changeMode(false);
                          }))
                  : SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          child: const Text('Sign in'),
                          onPressed: () async {
                            ref.read(loginProvider.notifier).changeMode(true);
                          })),
              const SizedBox(
                height: 8,
              ),
              // SizedBox(
              //     width: double.infinity,
              //     child: OutlinedButton(
              //         child: const Text('テスト'),
              //         onPressed: () async {
              //           await Navigator.of(context).pushNamed('/test');
              //         })),
            ],
          ),
        ),
      ),
    );
  }
}

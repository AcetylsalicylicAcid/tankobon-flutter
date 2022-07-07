import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tankobon/domain/models/login.dart';
import 'package:tankobon/l10n/l10n.dart';

class TestApiView extends HookWidget {
  const TestApiView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final box = Hive.box<List<dynamic>>('testBox');

    final instanceController = useTextEditingController();
    final instanceText = useState('');

    final loginController = useTextEditingController();
    final loginText = useState('');

    final passwordController = useTextEditingController();
    final passwordText = useState('');

    final hook = useState('');

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterAppBarTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Center(
            child: Wrap(
              runSpacing: 30,
              spacing: 10,
              children: <Widget>[
                Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Instance',
                      ),
                      focusNode: useFocusNode(),
                      controller: instanceController,
                      onChanged: (e) => instanceText.value = e,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Login',
                      ),
                      focusNode: useFocusNode(),
                      controller: loginController,
                      onChanged: (e) => loginText.value = e,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      focusNode: useFocusNode(),
                      controller: passwordController,
                      onChanged: (e) => passwordText.value = e,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        box.put(
                          'key',
                          [
                            ...(box.get('key') ?? []).map((e) => e as Login),
                            Login(
                              instance: instanceText.value,
                              username: loginText.value,
                              password: passwordText.value,
                            ),
                          ],
                        );
                        hook.notifyListeners();
                      },
                      child: const Text('login'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        box.delete('key');
                        hook.notifyListeners();
                      },
                      child: const Text('clean'),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('pref list'),
                        Text(
                          box
                                  .get('key')
                                  ?.map((e) => (e as Login).toString())
                                  .join(' ') ??
                              'empty',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

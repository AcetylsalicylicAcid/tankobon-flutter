import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tankobon/domain/models/login.dart';
import 'package:tankobon/l10n/l10n.dart';
import 'package:tankobon/view/test_api_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final tmpDir = await getTemporaryDirectory();
  // await Hive.initFlutter(tmpDir.toString());
  // Hive.registerAdapter(LoginAdapter());
  await Hive.initFlutter();
  Hive.registerAdapter(LoginAdapter());
  await Hive.openBox<List<dynamic>>('testBox');

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useEffect(() {
    //   Provider.of<DioState>(context, listen: false).setDio(Dio());
    //   SharedPreferences.getInstance().then(
    //     (value) => Provider.of<SharedPreferencesState>(context, listen: false)
    //         .setSharedPreferences(value),
    //   );
    //   Connectivity().onConnectivityChanged.listen((ConnectivityResult value) {
    //     Provider.of<ConnectivityState>(context, listen: false)
    //         .setConnectivityStatus(value);
    //   });
    //   return null;
    // });

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const TestApiView(),
    );
  }
}

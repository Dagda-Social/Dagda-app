import 'package:dagda/l10n/l10n.dart';
import 'package:dagda/meta_strategy/non_web_meta_strategy.dart'
    if (dart.library.html) 'package:dagda/meta_strategy/web_meta_strategy.dart';
import 'package:dagda/provider/locale_provider.dart';
import 'package:dagda/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:universal_io/io.dart';
import './urlStrategy/nonweb_rul_strategy.dart'
    if (dart.library.html) './urlStrategy/web_url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  configMeta(Locale.fromSubtags(languageCode: Platform.localeName));

  configureUrl();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dagda',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: L10n.all,
      theme: ThemeData(
        fontFamily: 'Comfortaa',
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.white, primary: Colors.white),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Colors.black),
          radius: const Radius.circular(10),
          trackColor: MaterialStateProperty.all(Colors.grey),
          trackBorderColor: MaterialStateProperty.all(Colors.grey),
        ),
      ),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            MetaSEO metaSEO = MetaSEO(
                ogTitle: AppLocalizations.of(context).dagdaSocial,
                description:
                    '${AppLocalizations.of(context).buildingNextGeneration}, ${AppLocalizations.of(context).joinUs}',
                ogImage: 'https://dagda.social/assets/images/logo.png',
                keywords: AppLocalizations.of(context).appKeywords);

            metaSEO.seoOGImage();
            metaSEO.seoDescription();
            metaSEO.seoOGTitle();
            metaSEO.seoKeywords();

            return  MaterialPage(
              child: Title(
                  title: AppLocalizations.of(context).dagdaSocial,
                  color: Colors.black,
                  child: const MyHomePage()),
            );
          }),
      GoRoute(
          path: '/register',
          pageBuilder: (context, state) {
            MetaSEO metaSEO = MetaSEO(
                ogTitle:
                    '${AppLocalizations.of(context).appName} - ${AppLocalizations.of(context).register}',
                description:
                    '${AppLocalizations.of(context).buildingNextGeneration} ${AppLocalizations.of(context).joinUs}',
                ogImage: 'https://dagda.social/assets/images/logo.png',
                keywords:
                    "${AppLocalizations.of(context).appKeywords},${AppLocalizations.of(context).register}");

            metaSEO.seoOGImage();
            metaSEO.seoDescription();
            metaSEO.seoOGTitle();
            metaSEO.seoKeywords();

            return MaterialPage<void>(
              child: Title(
                  title: '${AppLocalizations.of(context).register} - dagda',
                  color: Colors.black,
                  child: const Register()),
            );
          }),
      GoRoute(
          path: '/login',
          pageBuilder: (context, state) {
            MetaSEO metaSEO = MetaSEO(
                ogTitle:
                    '${AppLocalizations.of(context).appName} - ${AppLocalizations.of(context).login}',
                description:
                    '${AppLocalizations.of(context).buildingNextGeneration} ${AppLocalizations.of(context).joinUs}',
                ogImage: 'https://dagda.social/assets/images/logo.png',
                keywords:
                    "${AppLocalizations.of(context).appKeywords},${AppLocalizations.of(context).login}");

            metaSEO.seoOGImage();
            metaSEO.seoDescription();
            metaSEO.seoOGTitle();
            metaSEO.seoKeywords();

            return MaterialPage<void>(
              child: Title(
                  title: '${AppLocalizations.of(context).login} - dagda',
                  color: Colors.black,
                  child: const Login()),
            );
          }),
      GoRoute(
          name: 'profile',
          path: '/@:idProfile',
          pageBuilder: (context, state) {
            MetaSEO metaSEO = MetaSEO(
              ogTitle: '${state.params['idProfile']} - dagda',
              description:
                  '${state.params['idProfile']} ${AppLocalizations.of(context).buildingNextGeneration} ${AppLocalizations.of(context).joinUs}',
              keywords:
                  '${AppLocalizations.of(context).appKeywords}, ${state.params['idProfile'].toString()}',
            );

            metaSEO.seoOGTitle();
            metaSEO.seoKeywords();

            return MaterialPage<void>(
              child: Title(
                  title: '${state.params['idProfile']} - dagda',
                  color: Colors.black,
                  child: Profile(id: state.params['idProfile'].toString())),
            );
          }),
      GoRoute(
        path: '/privacy-policy',
        pageBuilder: (context, state) {
          MetaSEO metaSEO = MetaSEO(
            ogTitle:
                '${AppLocalizations.of(context).appName} - ${AppLocalizations.of(context).privacyPolicy}',
            description:
                '${AppLocalizations.of(context).buildingNextGeneration} ${AppLocalizations.of(context).joinUs}',
            ogImage: 'https://dagda.social/assets/images/logo.png',
            keywords:
                "${AppLocalizations.of(context).appKeywords},${AppLocalizations.of(context).privacyPolicy}",
          );

          metaSEO.seoOGImage();
          metaSEO.seoDescription();
          metaSEO.seoOGTitle();
          metaSEO.seoKeywords();

          return const MaterialPage<void>(
            child: PrivacyPolicy(),
          );
        },
      ),
    ],
    errorBuilder: (context, state) {
      MetaSEO metaSEO = MetaSEO(
        ogTitle: '404 - Not Found',
        description:
            '${AppLocalizations.of(context).buildingNextGeneration} ${AppLocalizations.of(context).joinUs}',
        ogImage: 'https://dagda.social/assets/images/logo.png',
        keywords: "${AppLocalizations.of(context).appKeywords},404",
      );
      metaSEO.seoOGImage();
      metaSEO.seoDescription();
      metaSEO.seoOGTitle();
      metaSEO.seoKeywords();

      return Title(
          title: '404 - Not Found',
          color: Colors.black,
          child: const NotFound());
    },
    initialLocation: '/');

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(AppLocalizations.of(context).appName,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 72)),
            ],
          ),
        ),
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 200,
                ),
                Text(
                  AppLocalizations.of(context).buildingNextGeneration,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ]),
        ),
      ]),
    );
  }
}

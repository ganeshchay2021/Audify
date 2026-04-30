import 'dart:io';
import 'package:audify/core/config/theme/app_theme.dart';
import 'package:audify/core/routes/app_pages.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:audify/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.audify.channel.audio',
    androidNotificationChannelName: 'Audify Music Playback',
    androidNotificationOngoing: true,
  );

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://lhnlgskftdzmgzrgrlvn.supabase.co",
    anonKey: "sb_publishable_KsFD23TVWVvKfnhUb1azQw_oVlyUcdu",
  );

  //hydrated Cubit Initialization
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  //dependencies injection
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ThemeCubit())],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => GetMaterialApp(
          title: 'Audify',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          getPages: AppPages.pages,
          initialRoute: AppRoutes.splash,
        ),
      ),
    );
  }
}

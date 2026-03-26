import 'package:ejar/core/Manager/SwitchTheme/cubit/toggle_theme_cubit.dart';
import 'package:ejar/core/Theme/app_theme.dart';
import 'package:ejar/core/routes/app_routes.dart';
import 'package:ejar/features/MyProducts/presentation/screen/myProduct_screen.dart';
import 'package:ejar/features/Payment_Method/presentation/screens/payment_screen.dart';
import 'package:ejar/features/Profile/presentation/Manager/cubit/edit_profile_cubit.dart';
import 'package:ejar/features/auth/presentation/manager/LogOut/cubit/logout_cubit.dart';
import 'package:ejar/features/auth/presentation/manager/forgotPassword/cubit/forgot_password_cubit.dart';
import 'package:ejar/features/auth/presentation/pages/login_page_category.dart';
import 'package:ejar/features/auth/presentation/pages/signup_page.dart';
import 'package:ejar/features/auth/presentation/pages/spalsh_page.dart';
import 'package:ejar/features/favourite/presentation/screens/favourite_screen.dart';
import 'package:ejar/features/home/presentation/manager/index/cubit/current_index_cubit.dart';
import 'package:ejar/features/home/presentation/pages/home_page.dart';
import 'package:ejar/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  await Supabase.initialize(
    url: 'https://uwlcjjsbyobufliiueov.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3bGNqanNieW9idWZsaWl1ZW92Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA4NTI3NjEsImV4cCI6MjA4NjQyODc2MX0.pffbXuQAtbxEFjYzveeVEukiksrQPBU0it6Dr5UTZ7E',
  );

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CurrentIndexCubit()),
        BlocProvider(create: (context) => EditProfileCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => ForgotPasswordCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state,
            locale: Locale("en"),
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.home,
            routes: {
              AppRoutes.splash: (context) => SpalshPage(),
              AppRoutes.login: (context) => LoginPageCategory(),
              AppRoutes.signup: (context) => SignupScreen(),
              AppRoutes.home: (context) => HomePage(),
              AppRoutes.favorites: (context) => FavouriteScreen(),
              AppRoutes.myProduct: (context) => MyProductsScreen(),
            },
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        },
      ),
    );
  }
}

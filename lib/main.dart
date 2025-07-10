import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/services/dio_service.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/features/addtocard/presentation/cubits/addtocard/addtocard_cubit.dart';
import 'package:fruits_hub/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';
import 'package:fruits_hub/features/home/presentation/cubit/category/category_cubit.dart';
import 'package:fruits_hub/features/home/presentation/cubit/products/all_products_cubit.dart';
import 'package:fruits_hub/features/home/presentation/cubit/sort/sort_cubit.dart';
import 'package:fruits_hub/features/setting/presentation/views/cubits/local/loacal_cubit.dart';
import 'package:fruits_hub/features/setting/presentation/views/cubits/theme/theme_cubit.dart';
import 'package:fruits_hub/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Prefs.init();

  final themeCubit = ThemeCubit();
  final localeCubit = LocaleCubit();

  runApp(ECommerceApp(themeCubit: themeCubit, localeCubit: localeCubit));
}

class ECommerceApp extends StatefulWidget {
  final ThemeCubit themeCubit;
  final LocaleCubit localeCubit;

  const ECommerceApp({super.key, required this.themeCubit, required this.localeCubit});

  @override
  State<ECommerceApp> createState() => _ECommerceAppState();
}

class _ECommerceAppState extends State<ECommerceApp> {
  bool _isThemeLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    await widget.themeCubit.loadSavedTheme();
    setState(() {
      _isThemeLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isThemeLoaded) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: widget.themeCubit),
            BlocProvider.value(value: widget.localeCubit),
            BlocProvider<ProductCubit>(
              create: (_) => ProductCubit(DioService())..fetchProducts(),
            ),
            BlocProvider<SortCubit>(
              create: (context) => SortCubit(context.read<ProductCubit>()),
            ),
            BlocProvider<CategoryCubit>(
              create: (_) => CategoryCubit(DioService())..fetchCategoriesWithImages(),
            ),
            BlocProvider(create: (_) {
              final cubit = CartCubit();
              cubit.loadCartFromPrefs();
              return cubit;
            }),
            BlocProvider(create: (_) {
              final cubit = FavoriteCubit();
              cubit.loadFavoritesFromPrefs();
              return cubit;
            }),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) {
              return BlocBuilder<LocaleCubit, Locale>(
                builder: (context, locale) {
                  return MaterialApp(
                    locale: locale,
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData.light().copyWith(
                      scaffoldBackgroundColor: Colors.white,
                      appBarTheme: const AppBarTheme(
                        backgroundColor: Colors.white,
                        elevation: 1,
                        iconTheme: IconThemeData(color: Colors.black),
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    darkTheme: ThemeData.dark(),
                    themeMode: mode,
                    home: const OnboardingView(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

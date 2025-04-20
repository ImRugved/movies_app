import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Utils/routes.dart';
import 'Constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Movies App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryDark,
              primary: AppColors.primaryDark,
              secondary: AppColors.primaryBlue,
              tertiary: AppColors.accentRed,
              background: AppColors.cardBackground,
              surface: AppColors.cardBackground,
              error: AppColors.error,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.primaryDark,
              foregroundColor: AppColors.textLight,
              centerTitle: true,
              elevation: 0,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: AppColors.textLight,
                elevation: 2,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            cardTheme: CardTheme(
              color: AppColors.cardBackground,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 8.h,
              ),
            ),
            scaffoldBackgroundColor: AppColors.background,
            textTheme: TextTheme(
              headlineMedium: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                color: AppColors.textDark,
              ),
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: AppColors.textDark,
              ),
              titleMedium: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.textPrimary,
              ),
              bodyLarge: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textPrimary,
              ),
              bodyMedium: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          initialRoute: Routes.splash,
          getPages: Routes.pages,
        );
      },
    );
  }
}

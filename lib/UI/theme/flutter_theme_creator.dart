import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:your_advisor/UI/theme/app_theme.dart';

class FlutterThemeCreator {
  late ThemeData _themeData;
  late AppTheme _appTheme;

  ThemeData createFlutterTheme(AppTheme theme) {
    _appTheme = theme;
    return _createFromFlexScheme(_getTextTheme());
  }

  ThemeData _createFromFlexScheme(TextTheme textTheme) {
    var accessibilityIsOn = _appTheme.accessibilityModeIsOn;
    const subThemesData = FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    );
    var themeData = !_appTheme.isDark
        ? FlexThemeData.light(
            colors: const FlexSchemeColor(
              primary: Color(0xFF006E01),
              primaryContainer: Color(0xFF77FF62),
              secondary: Color(0xFF020200),
              secondaryContainer: Color(0xFFFFDBCF),
              tertiary: Color(0xFF4C2100),
              tertiaryContainer: Color(0xFF95F0FF),
              appBarColor: Color(0xFFFFDBCF),
              error: Color(0xFFBA1A1A),
              errorContainer: Color(0xFFFFDAD6),
            ),
            textTheme:
                accessibilityIsOn ? textTheme.apply(fontSizeFactor: 1.2) : textTheme,
            usedColors: 7,
            subThemesData: accessibilityIsOn
                ? subThemesData.copyWith(
                    thinBorderWidth: 3,
                    thickBorderWidth: 5,
                    interactionEffects: true,
                    tintedDisabledControls: true,
                    useM2StyleDividerInM3: true,
                    inputDecoratorIsFilled: true,
                    inputDecoratorBorderType: FlexInputBorderType.outline,
                    alignedDropdown: true,
                    navigationRailUseIndicator: true,
                    navigationRailLabelType: NavigationRailLabelType.all,
                    fabRadius: 0,
                    cardRadius: 0,
                    chipRadius: 0,
                    menuRadius: 0,
                    dialogRadius: 0,
                    defaultRadius: 0,
                    textButtonRadius: 0,
                    filledButtonRadius: 0,
                    elevatedButtonRadius: 0,
                    outlinedButtonRadius: 0,
                    toggleButtonsRadius: 0,
                    segmentedButtonRadius: 0,
                    searchBarRadius: 0,
                    inputDecoratorRadius: 0,
                    defaultRadiusAdaptive: 0,
                    menuBarRadius: 0,
                    tooltipRadius: 0,
                    inputDecoratorRadiusAdaptive: 0,
                    navigationRailIndicatorRadius: 0,
                    navigationBarIndicatorRadius: 0,
                    tabBarIndicatorTopRadius: 0,
                    drawerIndicatorRadius: 0,
                    inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
                    inputDecoratorSchemeColor: SchemeColor.surfaceContainerLowest,
                    inputDecoratorFocusedBorderWidth: 2,
                    inputDecoratorBorderWidth: 2,
                    inputCursorSchemeColor: SchemeColor.primary,
                  )
                : subThemesData,
            // ColorScheme seed generation configuration for light mode.
            keyColors: const FlexKeyColors(
              useSecondary: true,
              useTertiary: true,
            ),
            tones: accessibilityIsOn
                ? FlexTones.ultraContrast(Brightness.light)
                : FlexSchemeVariant.candyPop.tones(Brightness.light),
            // Direct ThemeData properties.
            visualDensity: accessibilityIsOn
                ? VisualDensity.standard
                : FlexColorScheme.comfortablePlatformDensity,
          )
        : FlexThemeData.dark(
            // User defined custom colors made with FlexSchemeColor() API.
            colors: const FlexSchemeColor(
              primary: Color(0xFF9FC9FF),
              primaryContainer: Color(0xFF00325B),
              primaryLightRef: Color(0xFF006E01), // The color of light mode primary
              secondary: Color(0xFFFFB59D),
              secondaryContainer: Color(0xFF872100),
              secondaryLightRef: Color(0xFF020200), // The color of light mode secondary
              tertiary: Color(0xFF86D2E1),
              tertiaryContainer: Color(0xFF004E59),
              tertiaryLightRef: Color(0xFF4C2100), // The color of light mode tertiary
              appBarColor: Color(0xFFFFDBCF),
              error: Color(0xFFFFB4AB),
              errorContainer: Color(0xFF93000A),
            ),
            textTheme:
                accessibilityIsOn ? textTheme.apply(fontSizeFactor: 1.2) : textTheme,
            usedColors: 7,
            subThemesData: accessibilityIsOn
                ? subThemesData.copyWith(
                    thinBorderWidth: 3,
                    thickBorderWidth: 5,
                    interactionEffects: true,
                    tintedDisabledControls: true,
                    useM2StyleDividerInM3: true,
                    inputDecoratorIsFilled: true,
                    inputDecoratorBorderType: FlexInputBorderType.outline,
                    alignedDropdown: true,
                    navigationRailUseIndicator: true,
                    navigationRailLabelType: NavigationRailLabelType.all,
                    fabRadius: 0,
                    cardRadius: 0,
                    chipRadius: 0,
                    menuRadius: 0,
                    dialogRadius: 0,
                    defaultRadius: 0,
                    textButtonRadius: 0,
                    filledButtonRadius: 0,
                    elevatedButtonRadius: 0,
                    outlinedButtonRadius: 0,
                    toggleButtonsRadius: 0,
                    segmentedButtonRadius: 0,
                    searchBarRadius: 0,
                    inputDecoratorRadius: 0,
                    defaultRadiusAdaptive: 0,
                    menuBarRadius: 0,
                    tooltipRadius: 0,
                    inputDecoratorRadiusAdaptive: 0,
                    navigationRailIndicatorRadius: 0,
                    navigationBarIndicatorRadius: 0,
                    tabBarIndicatorTopRadius: 0,
                    drawerIndicatorRadius: 0,
                    inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
                    inputDecoratorSchemeColor: SchemeColor.surfaceContainerLowest,
                    inputDecoratorFocusedBorderWidth: 2,
                    inputDecoratorBorderWidth: 2,
                    inputCursorSchemeColor: SchemeColor.primary,
                  )
                : subThemesData,
            keyColors: const FlexKeyColors(
              useSecondary: true,
              useTertiary: true,
            ),
            tones: accessibilityIsOn
                ? FlexTones.ultraContrast(Brightness.dark)
                : FlexSchemeVariant.candyPop.tones(Brightness.dark),
            // Direct ThemeData properties.
            visualDensity: accessibilityIsOn
                ? VisualDensity.standard
                : FlexColorScheme.comfortablePlatformDensity,
          );

    themeData = themeData.copyWith(
        iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
                iconSize: _appTheme.accessibilityModeIsOn ? 28 : null)));
    return themeData;
  }

  TextTheme _getNunitoTextTheme() {
    const fontFamily = 'Nunito';
    final textColor = null;
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }

  TextTheme _getTextTheme() {
    var textTheme = _getNunitoTextTheme();
    if (_appTheme.accessibilityModeIsOn) {
      textTheme = textTheme.apply(fontSizeFactor: 1.2);
    }
    return textTheme;
  }
}

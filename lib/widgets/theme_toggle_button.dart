// lib/widgets/theme_toggle_button.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;
        
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      AppTheme.primaryDark,
                      AppTheme.secondaryDark,
                    ]
                  : [
                      AppTheme.primaryLight,
                      AppTheme.secondaryLight,
                    ],
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: AppTheme.getElevationShadow(
              isLight: !isDark,
              elevation: 4,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                themeProvider.toggleTheme();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon with smooth transition
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return RotationTransition(
                          turns: animation,
                          child: child,
                        );
                      },
                      child: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        key: ValueKey(isDark),
                        color: isDark 
                            ? AppTheme.onPrimaryDark
                            : AppTheme.onPrimaryLight,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Text with theme-appropriate styling
                    Text(
                      isDark ? 'فاتح' : 'غامق',
                      style: TextStyle(
                        color: isDark 
                            ? AppTheme.onPrimaryDark
                            : AppTheme.onPrimaryLight,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        shadows: [
                          Shadow(
                            offset: const Offset(0.5, 0.5),
                            blurRadius: 1,
                            color: isDark 
                                ? AppTheme.shadowDark.withValues(alpha: 0.3)
                                : AppTheme.shadowLight.withValues(alpha: 0.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Alternative compact version - just icon
class CompactThemeToggleButton extends StatelessWidget {
  const CompactThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;
        
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      AppTheme.primaryDark,
                      AppTheme.secondaryDark,
                    ]
                  : [
                      AppTheme.primaryLight,
                      AppTheme.secondaryLight,
                    ],
            ),
            shape: BoxShape.circle,
            boxShadow: AppTheme.getElevationShadow(
              isLight: !isDark,
              elevation: 3,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                themeProvider.toggleTheme();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: animation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    key: ValueKey(isDark),
                    color: isDark 
                        ? AppTheme.onPrimaryDark
                        : AppTheme.onPrimaryLight,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
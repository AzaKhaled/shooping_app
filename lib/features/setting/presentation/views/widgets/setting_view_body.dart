import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/features/addtocard/presentation/cubits/addtocard/addtocard_cubit.dart';
import 'package:fruits_hub/features/addtocard/presentation/cubits/addtocard/addtocard_state.dart';
import 'package:fruits_hub/features/auth/presentation/views/sigin_view.dart';
import 'package:fruits_hub/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';
import 'package:fruits_hub/features/setting/presentation/views/cubits/theme/theme_cubit.dart';
import 'package:fruits_hub/generated/l10n.dart';

class SettingViewBody extends StatelessWidget {
  const SettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return ListView(
      children: [
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            final isDark = mode == ThemeMode.dark;

            return SwitchListTile(
              title: Text(s.changeTheme),
              secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              value: isDark,
              activeColor: Colors.green, // ✅ لون السويتش وهو ON (الدائرة)
              activeTrackColor:
                  Colors.green.shade200, // ✅ لون المسار خلف السويتش
              onChanged: (_) {
                context.read<ThemeCubit>().toggleTheme();
              },
            );
          },
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: Text(s.logout),
          onTap: () async {
            final userJson = Prefs.getString('userData');
            final userMap = userJson.isNotEmpty ? jsonDecode(userJson) : null;

            if (userMap != null) {
              context.read<FavoriteCubit>().emit([]);
              context.read<CartCubit>().emit(CartState());

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const SiginView()),
                (route) => false,
              );
            }
          },
        ),
      ],
    );
  }
}

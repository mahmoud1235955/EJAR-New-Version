import 'package:ejar/core/Manager/SwitchTheme/cubit/toggle_theme_cubit.dart';
import 'package:ejar/core/colors/app_color.dart';
import 'package:ejar/core/extensions/sized_box_extenstion.dart';
import 'package:ejar/core/routes/app_routes.dart';
import 'package:ejar/core/routes/custom_auth_field.dart';
import 'package:ejar/features/Profile/presentation/Manager/ReciveProfileData/cubit/recive_profile_data_cubit.dart';
import 'package:ejar/features/Profile/presentation/Manager/cubit/edit_profile_cubit.dart';
import 'package:ejar/features/auth/presentation/manager/LogOut/cubit/logout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReciveProfileDataCubit()..getProfileData(),
        ),
      ],
      child: SingleChildScrollView(
        child: BlocBuilder<ReciveProfileDataCubit, ReciveProfileDataState>(
          builder: (context, state) {
            if (state is ReciveProfileDataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReciveProfileDataError) {
              return Center(child: Text(state.message));
            } else if (state is ReciveProfileDataSuccess) {
              return Column(
                children: [
                  const SizedBox(height: 30),
                  // 1. الجزء العلوي: الصورة والاسم
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(width: double.infinity),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xff087513), // لونك المفضل
                        child: CircleAvatar(
                          radius: 56,
                          backgroundImage: NetworkImage(
                            state.profile.image_url,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: MediaQuery.of(context).size.width * 0.25,
                        child: IconButton(
                          onPressed: () {
                            ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );
                          },
                          icon: Icon(Icons.edit, color: Colors.black, size: 40),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    state.profile.full_name, // اسمك المعتمد
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.profile.bio, // مهنتك
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 25),

                  // 2. كروت البيانات (Profile Info)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _buildInfoCard(
                          icon: Icons.email_outlined,
                          title: "Email",
                          subtitle: state.profile.email, // إيميلك
                        ),
                        _buildInfoCard(
                          icon: Icons.phone_android_outlined,
                          title: "Phone",
                          subtitle: state.profile.phone, // رقمك
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.language,
                            color: AppColors.primary,
                          ),
                          title: const Text(
                            "Arabic ",
                            style: TextStyle(
                              fontSize: 16,
                              //    color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Icon(Icons.change_circle_outlined),
                          onTap: () {},
                        ),
                        20.gap,
                        BlocBuilder<ThemeCubit, ThemeMode>(
                          builder: (context, state) {
                            return ListTile(
                              leading: const Icon(Icons.brightness_6),
                              title: Text(
                                state == ThemeMode.dark ? "Dark" : "Dark",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Switch(
                                // بيفحص الحالة الحالية هل هي Dark ولا لا
                                value:
                                    context.read<ThemeCubit>().state ==
                                    ThemeMode.dark,
                                onChanged: (isDark) {
                                  // بينادي على الميثود اللي بتعمل emit وتخزن في الـ Hydrated أوتوماتيك
                                  context.read<ThemeCubit>().toggleTheme(
                                    isDark,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 3. قسم الإعدادات السريعة
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Divider(),
                        _buildMenuTile(
                          Icons.production_quantity_limits,
                          "My Products",
                          onTap: () =>
                              Navigator.pushNamed(context, AppRoutes.myProduct),
                          context: context,
                        ),
                        _buildMenuTile(
                          context: context,
                          Icons.favorite_border,
                          "Saved Items",
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.favorites);
                          },
                        ),
                        _buildMenuTile(
                          context: context,
                          Icons.logout,
                          "Logout",
                          isLogout: true,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Logout"),
                                  content: Text(
                                    "Are you sure you want to logout?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No"),
                                    ),
                                    BlocBuilder<LogoutCubit, LogoutState>(
                                      builder: (context, state) {
                                        return TextButton(
                                          onPressed: () {
                                            context
                                                .read<LogoutCubit>()
                                                .logout();
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              AppRoutes.login,
                                              (route) => false,
                                            );
                                          },
                                          child: Text("Yes"),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<ReciveProfileDataCubit, ReciveProfileDataState>(
                    builder: (context, reciveState) {
                      if (reciveState is ReciveProfileDataLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (reciveState is ReciveProfileDataError) {
                        return Center(child: Text(reciveState.message));
                      } else if (reciveState is ReciveProfileDataSuccess) {
                        return ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Edit Profile"),
                                content: SingleChildScrollView(
                                  child: Expanded(
                                    child:
                                        BlocBuilder<
                                          EditProfileCubit,
                                          EditProfileState
                                        >(
                                          builder: (context, state) {
                                            final cubit = context
                                                .read<EditProfileCubit>();
                                            cubit.nameController.text =
                                                reciveState.profile.full_name;
                                            cubit.bioController.text =
                                                reciveState.profile.bio;
                                            cubit.emailController.text =
                                                reciveState.profile.email;
                                            cubit.phoneController.text =
                                                reciveState.profile.phone;
                                            return Column(
                                              children: [
                                                CustomAuthField(
                                                  controller:
                                                      cubit.nameController,
                                                  label: "Name",
                                                  icon: Icons.person,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  maxLines: 1,
                                                ),
                                                10.gap,
                                                CustomAuthField(
                                                  controller:
                                                      cubit.bioController,
                                                  label: "Bio",
                                                  icon: Icons.person,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  maxLines: 1,
                                                ),
                                                10.gap,
                                                CustomAuthField(
                                                  controller:
                                                      cubit.emailController,
                                                  label: "Email",
                                                  icon: Icons.email,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  maxLines: 1,
                                                ),
                                                10.gap,
                                                CustomAuthField(
                                                  controller:
                                                      cubit.phoneController,
                                                  label: "Phone",
                                                  icon: Icons.phone,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  maxLines: 1,
                                                ),
                                                10.gap,
                                              ],
                                            );
                                          },
                                        ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await context
                                          .read<EditProfileCubit>()
                                          .updateProfile();
                                      Navigator.pop(context);
                                    },
                                    child: Text("Save"),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xff087513,
                            ), // لونك المفضل
                            maximumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              );
            } else {
              return const Center(child: Text("Loading..."));
            }
          },
        ),
      ),
    );
  }

  // ويدجت مساعدة لعرض كروت البيانات
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 0,
      color: Colors.grey[50],
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xff087513)),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // ويدجت مساعدة لعرض خيارات المنيو
  Widget _buildMenuTile(
    IconData icon,
    String title, {
    bool isLogout = false,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : AppColors.primary),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout
              ? Colors.red
              : Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}

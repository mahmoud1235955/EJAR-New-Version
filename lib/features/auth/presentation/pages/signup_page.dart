import 'package:ejar/core/colors/app_color.dart';
import 'package:ejar/core/routes/custom_auth_field.dart';
import 'package:ejar/features/auth/presentation/manager/signup/cubit/signup_cubit.dart';
import 'package:ejar/features/auth/presentation/pages/login_page_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state is SignupSuccess) {
                // عرض رسالة نجاح والانتقال لصفحة اللوجين
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Account created successfully!"),
                    backgroundColor: AppColors.primary,
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPageCategory()),
                );
              } else if (state is SignupFailure) {
                // عرض الخطأ اللي جاي من السوبابيز
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Create New Account",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Welcome! Please enter your details to create an account.",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(height: 40),

                      CustomAuthField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        label: "Full Name",
                        icon: Icons.person_outline,
                        validator: (value) => value!.isEmpty
                            ? "Please enter your full name"
                            : null,
                      ),
                      const SizedBox(height: 20),

                      CustomAuthField(
                        maxLines: 1,
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        label: "Phone Number",
                        icon: Icons.phone_android_outlined,
                        validator: (value) => value!.isEmpty
                            ? "Please enter your phone number"
                            : null,
                      ),
                      const SizedBox(height: 20),

                      CustomAuthField(
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        label: "Email Address",
                        icon: Icons.email_outlined,
                        validator: (value) => value!.isEmpty
                            ? "Please enter your email address"
                            : null,
                      ),
                      const SizedBox(height: 20),

                      CustomAuthField(
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        label: "Password",
                        icon: Icons.lock_outline,
                        isPassword: true,
                        // نصيحة: الـ suffix يفضل يتربط بدالة الـ toggleVisibility في الكيوبيت
                        suffix: Icon(
                          context.watch<SignupCubit>().isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.primary,
                        ),
                        validator: (value) => value!.length < 6
                            ? "Password must be at least 6 characters"
                            : null,
                      ),

                      const SizedBox(height: 40),

                      // زر التسجيل مع حالة الـ Loading
                      state is SignupLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // مناداة الدالة بالبيانات الحقيقية
                                  context.read<SignupCubit>().signup(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    nameController.text.trim(),
                                    phoneController.text.trim(),
                                  );
                                }
                              },
                              child: const Text(
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPageCategory(),
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

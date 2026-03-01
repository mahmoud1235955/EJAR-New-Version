import 'package:flutter/material.dart';

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          // 1. الجزء العلوي: الصورة والاسم
          const CircleAvatar(
            radius: 60,
            backgroundColor: Color(0xff087513), // لونك المفضل
            child: CircleAvatar(
              radius: 56,
              backgroundImage: AssetImage(
                "assets/images/mahmoud_profile.png",
              ), // صورتك
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Mahmoud Ashour", // اسمك المعتمد
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Communication & Electronics Engineer", // مهنتك
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
                  subtitle: "mahmoud11asd6@gmail.com", // إيميلك
                ),
                _buildInfoCard(
                  icon: Icons.phone_android_outlined,
                  title: "Phone",
                  subtitle: "01019734796", // رقمك
                ),
                _buildInfoCard(
                  icon: Icons.school_outlined,
                  title: "Instructor @",
                  subtitle: "IEEE Al-Azhar", // دورك التعليمي
                ),
                _buildInfoCard(
                  icon: Icons.location_city_outlined,
                  title: "University",
                  subtitle: "Al-Azhar University", // جامعتك
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
                _buildMenuTile(Icons.history, "My Listings (Ejar)"),
                _buildMenuTile(Icons.favorite_border, "Saved Items"),
                _buildMenuTile(Icons.settings_outlined, "Settings"),
                _buildMenuTile(Icons.logout, "Logout", isLogout: true),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
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
  Widget _buildMenuTile(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () {},
    );
  }
}

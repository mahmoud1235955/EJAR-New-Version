import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:ejar/features/editProfile/presentation/widgets/edit_profile_widget.dart';
import 'package:ejar/features/home/presentation/manager/index/cubit/current_index_cubit.dart';
import 'package:ejar/features/home/presentation/widgets/add_widget.dart';
import 'package:ejar/features/home/presentation/widgets/chat_widget.dart';
import 'package:ejar/features/home/presentation/widgets/home_widget.dart';
import 'package:ejar/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).ejar,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff075800),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: BlocBuilder<CurrentIndexCubit, CurrentIndexState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is CurrentIndexChanged) {
            currentIndex = state.index;
          }
          return currentIndex == 0
              ? HomeWidget()
              : currentIndex == 1
              ? ChatWidget()
              : currentIndex == 2
              ? AddSelectionSheet()
              : currentIndex == 3
              ? Container()
              : currentIndex == 4
              ? EditProfileWidget()
              : Container();
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        color: Colors.white,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home, size: 30),
            label: "Home",
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.chat_bubble_outline, size: 30),
            label: "Chats",
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.add, size: 30),
            label: "Add",
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.favorite, size: 30),
            label: "Favorites",
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person, size: 30),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          context.read<CurrentIndexCubit>().changeIndex(index);
        },
      ),
    );
  }
}

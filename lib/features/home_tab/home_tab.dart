import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/services/injection_container.dart';
import 'package:event_app/features/event/presentation/my_event_screen.dart';
import 'package:event_app/features/home/presentation/home_page.dart';
import 'package:event_app/features/login/data/models/user_info.dart';
import 'package:event_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/profile/profile_page.dart';
import 'package:event_app/features/purchases/presentation/purchases_screen.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/utils/media_res.dart';
import 'package:event_app/global/views/page_under_construction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // * Holds the index of the currently selected tab
  // in the bottom navigation bar
  int currentIndex = 0;
  bool resultComing = false;
  UserInfo _userInfo = UserInfo();

  // * List of screens that are displayed in the bottom navigation bar

  final tabs = const [
    HomePage(),
    Scaffold(backgroundColor: Colors.white, body: PageUnderConstruction()),
    MyEventScreen(),
    PurchasesScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>()
        ..add(
          GetUserInfoEvent(),
        ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is GetUserInfoState) {
            _userInfo = state.userInfo;
            resultComing = true;
          } else if (state is LoggedOutState) {
            Navigator.of(context).pushReplacementNamed(
              loginPage,
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return resultComing
                ? SafeArea(
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      bottomNavigationBar: BottomNavigationBar(
                        backgroundColor: Colors.white,
                        currentIndex: currentIndex,
                        type: BottomNavigationBarType.fixed,
                        items: [
                          BottomNavigationBarItem(
                            activeIcon: SvgPicture.asset(
                              MediaRes.homeIcon,
                              height: 26,
                              colorFilter: const ColorFilter.mode(
                                appPrimaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            icon: SvgPicture.asset(MediaRes.homeIcon),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            activeIcon: SvgPicture.asset(
                              MediaRes.exploreIcon,
                              height: 26,
                            ),
                            icon: SvgPicture.asset(MediaRes.exploreIcon),
                            label: 'Explore',
                          ),
                          BottomNavigationBarItem(
                            activeIcon: SvgPicture.asset(
                              MediaRes.exploreIcon,
                              height: 26,
                            ),
                            icon: SvgPicture.asset(MediaRes.exploreIcon),
                            label: 'My Events',
                          ),
                          BottomNavigationBarItem(
                            activeIcon: SvgPicture.asset(
                              MediaRes.purchasesIcon,
                              height: 26,
                              colorFilter: const ColorFilter.mode(
                                appPrimaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            icon: SvgPicture.asset(MediaRes.purchasesIcon),
                            label: 'Purchases',
                          ),
                          BottomNavigationBarItem(
                            activeIcon: SvgPicture.asset(
                              MediaRes.profileIcon,
                              height: 26,
                              colorFilter: const ColorFilter.mode(
                                appPrimaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            icon: SvgPicture.asset(MediaRes.profileIcon),
                            label: 'Profile',
                          ),
                        ],
                        onTap: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      body: IndexedStack(
                        index: currentIndex,
                        children: tabs,
                      ),
                    ),
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}

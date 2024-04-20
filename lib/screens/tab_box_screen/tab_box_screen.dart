import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_project/screens/generate_screen/generate_screen.dart';
import 'package:qr_code_project/screens/history_screen/history_product_screen.dart';
import 'package:qr_code_project/utils/app_img/app_img.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../utils/app_colors/app_colors.dart';
import '../qr_scanner_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> _screens = [];
  int _activeIndex = 1;

  @override
  void initState() {
    _screens = [
      const GenerateScreen(),
      const HistoryProductScreen(),
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_333333,
      body: _screens[_activeIndex],
      bottomNavigationBar: Container(
        height: 67,
        margin: const EdgeInsets.symmetric(horizontal: 46),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: AppColors.c_333333,
        ),
        child: BottomNavigationBar(
          onTap: (newActiveIndex) {
            _activeIndex = newActiveIndex;
            setState(() {});
          },
          selectedItemColor: AppColors.c_FDB623,
          unselectedItemColor: AppColors.cd9,
          currentIndex: _activeIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 16,
          unselectedFontSize: 14,
          backgroundColor: Colors.black.withOpacity(.6),
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.qr_code,
                color: AppColors.c_FDB623,
              ),
              icon: Icon(Icons.qr_code,color: AppColors.cd9,),
              label: "Generate",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.history,
                color: AppColors.c_FDB623,
              ),
              icon: Icon(Icons.history,color: AppColors.cd9,),
              label: "History",
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:ZoomTapAnimation(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const QrScannerScreen();
              },
            ),
          );
        },
        child: Container(
          height: 70,
          width: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 21,
                color: AppColors.c_FDB623,
              ),
            ],
            color: AppColors.c_FDB623,
          ),
          child: Center(
            child: SvgPicture.asset(AppImg.qrCode),
          ),
        ),
      ),
    );
  }
}
import 'package:cep_finder/core/extensions/context_extension.dart';
import 'package:cep_finder/core/res/colours.dart';
import 'package:cep_finder/core/res/fonts.dart';
import 'package:cep_finder/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({
    required this.currentIndex,
    super.key,
  });

  final int currentIndex;

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: _bottomTapped,
      elevation: 0,
      enableFeedback: false,
      selectedItemColor: Colours.tealBlue,
      unselectedItemColor: Colours.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      mouseCursor: SystemMouseCursors.none,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontFamily: Fonts.roboto,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: Fonts.roboto,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),

      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _buildIcon(MediaRes.mapIcon, 0),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(MediaRes.bookletIcon, 1),
          label: 'Cardeneta',
        ),
      ],
    );
  }

  Widget _buildIcon(String iconPath, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.currentIndex == index ? Colours.antiFlashWhite
            : Colors.transparent,
      ),
      child: SvgPicture.asset(
        iconPath,
        height: context.height * 0.045,
        colorFilter: ColorFilter.mode(
          widget.currentIndex == index ? Colours.tealBlue : Colours.grey,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  void _bottomTapped(int index) {
    if (index == 0) {
      context.go('/map');
    } else if (index == 1) {
      context.go('/booklet');
    }
  }
}

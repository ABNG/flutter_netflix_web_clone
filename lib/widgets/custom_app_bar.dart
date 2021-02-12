import 'package:flutter/material.dart';
import 'package:flutter_netflix_web_clone/assets.dart';
import 'package:flutter_netflix_web_clone/widgets/responsive.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  CustomAppBar({this.scrollOffset = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
        color: Colors.black
            .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
        child: Responsive(
          mobile: _CustomAppBarMobile(),
          desktop: _CustomAppBarDesktop(),
        ));
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                  title: "TV Shows",
                  onTap: () {},
                ),
                _AppBarButton(
                  title: "Movies",
                  onTap: () {},
                ),
                _AppBarButton(
                  title: "My List",
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                  title: "Home",
                  onTap: () {},
                ),
                _AppBarButton(
                  title: "TV Shows",
                  onTap: () {},
                ),
                _AppBarButton(
                  title: "Movies",
                  onTap: () {},
                ),
                _AppBarButton(
                  title: "My List",
                  onTap: () {},
                ),
                _AppBarButton(
                  title: "Latest",
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ReusableIconButton(icon: Icons.search),
                _AppBarButton(
                  title: "KIDS",
                  onTap: () {},
                ),
                _AppBarButton(
                  title: "DVD",
                  onTap: () {},
                ),
                _ReusableIconButton(
                  icon: Icons.card_giftcard,
                ),
                _ReusableIconButton(icon: Icons.notifications),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReusableIconButton extends StatelessWidget {
  final IconData icon;
  const _ReusableIconButton({
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          icon,
        ),
        padding: EdgeInsets.zero,
        iconSize: 28.0,
        color: Colors.white,
        onPressed: () {});
  }
}

class _AppBarButton extends StatelessWidget {
  final Function onTap;
  final String title;
  const _AppBarButton({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

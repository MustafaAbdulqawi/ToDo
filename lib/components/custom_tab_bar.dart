import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key, required this.tabController});
final TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerHeight: 0,
      tabs: [
        Tab(
          child: Text(
            "All",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Tab(
          child: Text(
            "Inprogress",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Tab(
          child: Text(
            "Waiting",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Tab(
          child: Text(
            "Finished",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      controller: tabController,
      indicatorColor: const Color(0XFF5f33e1),
      indicatorWeight: 4,
    );
  }
}

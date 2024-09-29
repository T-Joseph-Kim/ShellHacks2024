import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/views/utils/AppColor.dart';

class DummySearchBar extends StatelessWidget {
  final Function routeTo;
  DummySearchBar({required this.routeTo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: routeTo as void Function()?,
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side - Search Box
            Expanded(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(right: 0),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.secondary),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/search.svg', color: AppColor.primary2, height: 20, width: 20),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'Search Scanned Foods',
                        style: TextStyle(color: AppColor.primary2.withOpacity(0.8)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

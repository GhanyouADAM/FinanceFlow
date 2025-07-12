import 'package:flutter/material.dart';
import 'package:the_app/core/theme/build_extension.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return   Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: 21,
                width: 5,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5), bottom: Radius.circular(5))
                ),
              ),
            ),
            SizedBox(width: 7,),
            Text(title, style: context.textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w400
            ),)
          ],
        ),
      );
  }
}
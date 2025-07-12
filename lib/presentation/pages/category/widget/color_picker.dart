import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/theme/build_extension.dart';

class ColorPicker extends ConsumerWidget {
  const ColorPicker({super.key, required this.colors, this.selectedColor, required this.onSelectedColor});
final List<Color> colors;
final Color? selectedColor;
final ValueChanged<Color>onSelectedColor;
  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
        childAspectRatio: 3.5
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: colors.length,
        itemBuilder: (context, index){
          final color = colors[index];
          final isSelected = selectedColor == color;
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: InkWell(
              onTap: ()=> onSelectedColor(color),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? context.colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(40)
                ),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: color,
                ),
              ),
            ),
          );
        }),
    );
  }
}
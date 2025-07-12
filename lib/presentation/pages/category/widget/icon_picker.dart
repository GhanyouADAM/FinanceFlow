import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/theme/build_extension.dart';

class IconPicker extends ConsumerWidget {
  const IconPicker({super.key, required this.icons, required this.onSelectedIcon, this.selectedIcon, this.selectedColor});
  final List<IconData> icons; 
  final IconData? selectedIcon;
  final Color? selectedColor;
  final ValueChanged<IconData> onSelectedIcon;
  @override
  Widget build(BuildContext context, ref) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: icons.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1,
        childAspectRatio: 3
        ),
       itemBuilder: (context, index){
        final icon = icons[index];
        final isSelected = selectedIcon == icon;
            return InkWell(
              borderRadius: BorderRadius.circular(100),
              splashColor: context.colorScheme.primary.withValues(alpha: 2),
              onTap: () => onSelectedIcon(icon),
              child: CircleAvatar(
                backgroundColor: isSelected && selectedColor != null ? selectedColor : context.colorScheme.surface,
                foregroundColor: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
                  child: Icon(icon),
              ),
            );
       });
  }
}
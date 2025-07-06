import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/conversation.dart';

class CategoryTabs extends StatefulWidget {
  final List<ConversationType> categories;
  final int initialSelectedIndex;
  final Function(ConversationType category, int index)? onCategorySelected;

  const CategoryTabs({
    super.key,
    required this.categories,
    this.initialSelectedIndex = 0,
    this.onCategorySelected,
  });

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return const SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive values
    double containerHeight = 46.0;
    double leftPadding = 13.0;

    if (screenWidth >= 900) {
      containerHeight = 58.0;
      leftPadding = 32.0;
    } else if (screenWidth >= 600) {
      containerHeight = 52.0;
      leftPadding = 24.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      containerHeight = (46.0 * scaleFactor).clamp(46.0, 52.0);
      leftPadding = (13.0 * scaleFactor).clamp(13.0, 20.0);
    }

    return Container(
      height: containerHeight,
      padding: EdgeInsets.only(left: leftPadding, right: 0, top: 0, bottom: 0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) => _buildCategoryTab(index),
      ),
    );
  }

  Widget _buildCategoryTab(int index) {
    final category = widget.categories[index];
    final isSelected = index == selectedIndex;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive values
    double rightMargin = 12.0;
    double horizontalPadding = 12.0;
    double verticalPadding = 3.0;
    double iconTextSpacing = 3.0;

    if (screenWidth >= 900) {
      rightMargin = 16.0;
      horizontalPadding = 16.0;
      verticalPadding = 6.0;
      iconTextSpacing = 6.0;
    } else if (screenWidth >= 600) {
      rightMargin = 14.0;
      horizontalPadding = 14.0;
      verticalPadding = 4.0;
      iconTextSpacing = 4.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      rightMargin = (12.0 * scaleFactor).clamp(12.0, 14.0);
      horizontalPadding = (12.0 * scaleFactor).clamp(12.0, 14.0);
      verticalPadding = (3.0 * scaleFactor).clamp(3.0, 4.0);
      iconTextSpacing = (3.0 * scaleFactor).clamp(3.0, 4.0);
    }

    return GestureDetector(
      onTap: () => _handleTabSelection(category, index),
      child: Container(
        margin: EdgeInsets.only(
          right: index < widget.categories.length - 1 ? rightMargin : 0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(color: const Color(0xFFF3F4F6)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCategoryIcon(category.iconPath),
            SizedBox(width: iconTextSpacing),
            _buildCategoryTitle(category.title, isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(String iconPath) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive icon size and offset
    double iconWidth = 40.0;
    double iconHeight = 30.0;
    double offsetY = 3.0;
    double fallbackIconSize = 26.0;

    if (screenWidth >= 900) {
      iconWidth = 52.0;
      iconHeight = 39.0;
      offsetY = 4.0;
      fallbackIconSize = 32.0;
    } else if (screenWidth >= 600) {
      iconWidth = 46.0;
      iconHeight = 34.0;
      offsetY = 3.5;
      fallbackIconSize = 29.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      iconWidth = (40.0 * scaleFactor).clamp(40.0, 46.0);
      iconHeight = (30.0 * scaleFactor).clamp(30.0, 34.0);
      offsetY = (3.0 * scaleFactor).clamp(3.0, 3.5);
      fallbackIconSize = (26.0 * scaleFactor).clamp(26.0, 29.0);
    }

    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Image.asset(
        iconPath,
        width: iconWidth,
        height: iconHeight,
        errorBuilder:
            (context, error, stackTrace) => Icon(
              Icons.category,
              size: fallbackIconSize,
              color: AppColors.textPrimary,
            ),
      ),
    );
  }

  Widget _buildCategoryTitle(String title, bool isSelected) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive font size
    double fontSize = 14.0;

    if (screenWidth >= 900) {
      fontSize = 18.0;
    } else if (screenWidth >= 600) {
      fontSize = 16.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      fontSize = (14.0 * scaleFactor).clamp(14.0, 16.0);
    }

    return Text(
      title,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        fontSize: fontSize,
      ),
    );
  }

  void _handleTabSelection(ConversationType category, int index) {
    if (selectedIndex != index) {
      setState(() {
        selectedIndex = index;
      });
      widget.onCategorySelected?.call(category, index);
    }
  }
}

// Factory class to create default categories
class CategoryTabsFactory {
  static List<ConversationType> createDefaultCategories() {
    return [
      ConversationType(
        id: 'meetings',
        title: 'Meetings',
        iconPath: 'assets/images/meetings.png',
      ),
      ConversationType(
        id: 'chats',
        title: 'Chats',
        iconPath: 'assets/images/chats.png',
      ),
      ConversationType(
        id: 'thoughts',
        title: 'Thoughts',
        iconPath: 'assets/images/thoughts.png',
      ),
    ];
  }
}

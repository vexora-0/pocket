import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/conversation.dart';

class CategoryTabs extends StatefulWidget {
  final List<ConversationType> categories;
  final int initialSelectedIndex;
  final Function(ConversationType category, int index)? onCategorySelected;
  final double? height;
  final double? horizontalPadding;
  final double? itemSpacing;
  final double? fontSize;
  final double? iconWidth;
  final double? iconHeight;

  const CategoryTabs({
    super.key,
    required this.categories,
    this.initialSelectedIndex = 0,
    this.onCategorySelected,
    this.height,
    this.horizontalPadding,
    this.itemSpacing,
    this.fontSize,
    this.iconWidth,
    this.iconHeight,
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

    return Container(
      height: widget.height ?? 46,
      padding: EdgeInsets.only(
        left: widget.horizontalPadding ?? 13,
        right: 0,
        top: 0,
        bottom: 0,
      ),
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

    return GestureDetector(
      onTap: () => _handleTabSelection(category, index),
      child: Container(
        margin: EdgeInsets.only(
          right:
              index < widget.categories.length - 1
                  ? (widget.itemSpacing ?? 12)
                  : 0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        decoration: BoxDecoration(color: const Color(0xFFF3F4F6)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCategoryIcon(category.iconPath),
            const SizedBox(width: 3),
            _buildCategoryTitle(category.title, isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(String iconPath) {
    return Transform.translate(
      offset: const Offset(0, 3),
      child: Image.asset(
        iconPath,
        width: widget.iconWidth ?? 40,
        height: widget.iconHeight ?? 30,
        errorBuilder:
            (context, error, stackTrace) => Icon(
              Icons.category,
              size:
                  (widget.iconHeight ?? 30) *
                  0.87, // Proportional to icon height
              color: AppColors.textPrimary,
            ),
      ),
    );
  }

  Widget _buildCategoryTitle(String title, bool isSelected) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        fontSize: widget.fontSize ?? 14,
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

import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/conversation.dart';
import '../../../utils/color_utils.dart';

class ConversationCard extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback? onTap;
  final double? subtitleMaxWidth;
  final double? thumbnailWidth;
  final double? thumbnailHeight;
  final EdgeInsets? cardPadding;
  final double? contentSpacing;
  final double? titleSubtitleSpacing;

  const ConversationCard({
    super.key,
    required this.conversation,
    this.onTap,
    this.subtitleMaxWidth,
    this.thumbnailWidth,
    this.thumbnailHeight,
    this.cardPadding,
    this.contentSpacing,
    this.titleSubtitleSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            cardPadding ??
            const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            _buildGradientThumbnail(),
            SizedBox(width: contentSpacing ?? 14),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientThumbnail() {
    return Container(
      width: thumbnailWidth ?? 120,
      height: thumbnailHeight ?? 80,
      decoration: BoxDecoration(
        gradient: ColorUtils.createGradientFromInts(
          conversation.gradientColors,
        ),
        borderRadius: BorderRadius.circular(6), // Slightly more rounded
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(),
            SizedBox(height: titleSubtitleSpacing ?? 6),
            _buildSubtitleOrTime(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      conversation.title,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w800,
        height: 1.3, // Better line height
        letterSpacing: 0.1,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitleOrTime() {
    if (conversation.subtitle != null) {
      return _buildSubtitle();
    }

    if (conversation.time != null) {
      return _buildTime();
    }

    return const SizedBox.shrink();
  }

  Widget _buildSubtitle() {
    return Container(
      width: subtitleMaxWidth,
      child: Text(
        conversation.subtitle!,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          height: 1.4, // Better line height for readability
          letterSpacing: 0.05,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildTime() {
    return Text(
      conversation.time!,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 12,
        height: 1.3,
        letterSpacing: 0.05,
      ),
    );
  }
}

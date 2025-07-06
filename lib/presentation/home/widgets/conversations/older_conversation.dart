import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../data/models/conversation.dart';
import '../../../../utils/color_utils.dart';
import 'date_header.dart';

class OlderConversation extends StatelessWidget {
  final List<Conversation> conversations;
  final DateTime date;
  final double? cardWidth;
  final double? cardHeight;
  final double? horizontalPadding;
  final double? cardSpacing;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final double? iconSize;
  final double? titleIconSpacing;
  final double? titleSubtitleSpacing;
  final double? gradientToContentSpacing;
  final double? selectedDateFontSize;
  final double? conversationCountFontSize;
  final EdgeInsets? cardPadding;
  final VoidCallback? onTap;

  const OlderConversation({
    super.key,
    required this.conversations,
    required this.date,
    this.cardWidth,
    this.cardHeight,
    this.horizontalPadding,
    this.cardSpacing,
    this.titleFontSize,
    this.subtitleFontSize,
    this.iconSize,
    this.titleIconSpacing,
    this.titleSubtitleSpacing,
    this.gradientToContentSpacing,
    this.selectedDateFontSize,
    this.conversationCountFontSize,
    this.cardPadding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateHeader(
          date: date,
          conversationCount: conversations.length,
          horizontalPadding: horizontalPadding ?? 16.0,
          selectedDateFontSize: selectedDateFontSize ?? 16,
          conversationCountFontSize: conversationCountFontSize ?? 14,
        ),
        SizedBox(height: titleSubtitleSpacing ?? 16),
        _buildHorizontalScrollableCards(),
      ],
    );
  }

  Widget _buildHorizontalScrollableCards() {
    return SizedBox(
      height: cardHeight ?? 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: (horizontalPadding ?? 16.0) * 0.6,
        ),
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          final isLastCard = index == conversations.length - 1;

          return Container(
            width: cardWidth ?? 140,
            height: double.infinity,
            margin: EdgeInsets.only(
              right: isLastCard ? 0 : (cardSpacing ?? 16.0),
            ),
            child: _buildOlderConversationCard(conversation),
          );
        },
      ),
    );
  }

  Widget _buildOlderConversationCard(Conversation conversation) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        padding:
            cardPadding ??
            const EdgeInsets.all(12.0), // Increase padding for better spacing
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4), // Reduced border radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGradientContainer(conversation),
            SizedBox(height: gradientToContentSpacing ?? 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleWithIcon(conversation),
                  SizedBox(height: titleSubtitleSpacing ?? 8),
                  Expanded(child: _buildSubtitle(conversation)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientContainer(Conversation conversation) {
    final cardWidthValue = cardWidth ?? 140;
    // Make gradient container width match card width and be square
    return Container(
      width: cardWidthValue,
      height:
          cardWidthValue *
          0.75, // Adjust height to be more square and match Figma
      decoration: BoxDecoration(
        gradient: ColorUtils.createGradientFromInts(
          conversation.gradientColors,
        ),
        borderRadius: BorderRadius.circular(
          4,
        ), // Reduced border radius for squarer appearance
      ),
    );
  }

  Widget _buildTitleWithIcon(Conversation conversation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            conversation.title,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: titleFontSize ?? 14,
              fontWeight: FontWeight.w800,
              height: 1.3,
              letterSpacing: 0.1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _buildConversationIcon(),
      ],
    );
  }

  Widget _buildConversationIcon() {
    // Use platform-specific asset path for better cross-platform compatibility
    final assetPath = 'assets/svgs/conversation.svg';

    return SvgPicture.asset(
      assetPath,
      width: iconSize ?? 16,
      height: iconSize ?? 16,
      colorFilter: const ColorFilter.mode(
        AppColors.textPrimary,
        BlendMode.srcIn,
      ),
      // Add fallback for better error handling
      placeholderBuilder:
          (context) => Icon(
            Icons.chat_bubble_outline,
            size: iconSize ?? 16,
            color: AppColors.textPrimary,
          ),
      // Add error handler for debugging
      errorBuilder: (context, error, stackTrace) {
        debugPrint('SVG Error: $error');
        return Icon(
          Icons.chat_bubble_outline,
          size: iconSize ?? 16,
          color: AppColors.textPrimary,
        );
      },
    );
  }

  Widget _buildSubtitle(Conversation conversation) {
    if (conversation.subtitle == null) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        conversation.subtitle!,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: subtitleFontSize ?? 12,
          height: 1.4,
          letterSpacing: 0.05,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

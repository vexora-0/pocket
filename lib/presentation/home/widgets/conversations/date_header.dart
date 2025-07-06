import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class DateHeader extends StatelessWidget {
  final DateTime date;
  final int conversationCount;
  final double horizontalPadding;
  final double selectedDateFontSize;
  final double conversationCountFontSize;

  const DateHeader({
    super.key,
    required this.date,
    required this.conversationCount,
    required this.horizontalPadding,
    required this.selectedDateFontSize,
    required this.conversationCountFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDateDisplay(context),
          _buildConversationCountDisplay(context),
        ],
      ),
    );
  }

  Widget _buildDateDisplay(BuildContext context) {
    return Container(
      width: 200, // Fixed width to prevent shifting with longer day names
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            '${_getFullWeekday(date.weekday)},',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: selectedDateFontSize,
              height: 1.3,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            _formatDate(date),
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: selectedDateFontSize * 0.875,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationCountDisplay(BuildContext context) {
    return Row(
      children: [
        Text(
          conversationCount.toString(),
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: conversationCountFontSize,
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.chevron_right,
          size: conversationCountFontSize * 1.14,
          color: AppColors.textSecondary,
        ),
      ],
    );
  }

  String _getFullWeekday(int weekday) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[weekday - 1];
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final month = months[date.month - 1];
    final day = date.day;
    final year = date.year.toString().substring(2);

    return '$month $day \'$year';
  }
}

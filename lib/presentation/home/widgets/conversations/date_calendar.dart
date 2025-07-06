import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../data/models/conversation.dart';
import 'date_header.dart';

class DateCalendar extends StatefulWidget {
  final List<DateInfo> dates;
  final DateInfo? initialSelectedDate;
  final Function(DateInfo selectedDate)? onDateSelected;
  final int conversationCount;
  final double? horizontalPadding;
  final double? scrollerHeight;
  final double? headerFontSize;
  final double? dateNumberFontSize;
  final double? weekdayFontSize;
  final double? selectedDateFontSize;
  final double? conversationCountFontSize;
  final double? itemSpacing;
  final double? headerToScrollerSpacing;
  final double? scrollerToSelectedInfoSpacing;

  const DateCalendar({
    super.key,
    required this.dates,
    this.initialSelectedDate,
    this.onDateSelected,
    this.conversationCount = 0,
    this.horizontalPadding,
    this.scrollerHeight,
    this.headerFontSize,
    this.dateNumberFontSize,
    this.weekdayFontSize,
    this.selectedDateFontSize,
    this.conversationCountFontSize,
    this.itemSpacing,
    this.headerToScrollerSpacing,
    this.scrollerToSelectedInfoSpacing,
  });

  @override
  State<DateCalendar> createState() => _DateCalendarState();
}

class _DateCalendarState extends State<DateCalendar> {
  late DateInfo selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate =
        widget.initialSelectedDate ??
        (widget.dates.isNotEmpty ? widget.dates.first : _createDefaultDate());
  }

  DateInfo _createDefaultDate() {
    final now = DateTime.now();
    return DateInfo(
      date: now,
      weekday: _getWeekdayAbbreviation(now.weekday),
      shortWeekday: _getShortWeekday(now.weekday),
      fullWeekday: _getFullWeekday(now.weekday),
      isSelected: true,
    );
  }

  String _getWeekdayAbbreviation(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  String _getShortWeekday(int weekday) {
    const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return weekdays[weekday - 1];
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

  @override
  Widget build(BuildContext context) {
    if (widget.dates.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: widget.headerToScrollerSpacing ?? 16),
          _buildDateScroller(),
          SizedBox(height: widget.scrollerToSelectedInfoSpacing ?? 16),
          _buildSelectedDateInfo(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      'Your conversations',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        fontSize: widget.headerFontSize,
      ),
    );
  }

  Widget _buildDateScroller() {
    return SizedBox(
      height: widget.scrollerHeight ?? 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.dates.length,
        itemBuilder: (context, index) => _buildDateItem(index),
      ),
    );
  }

  Widget _buildDateItem(int index) {
    final dateInfo = widget.dates[index];
    final isSelected = _isSameDate(dateInfo.date, selectedDate.date);
    final isToday = index == 1; // Hardcoded to 4th position (Friday)
    final baseSize = widget.dateNumberFontSize ?? 15;
    final buttonPadding = baseSize * 0.8; // Proportional padding
    final buttonWidth = baseSize * 3.2; // Proportional width

    return GestureDetector(
      onTap: () => _handleDateSelection(dateInfo),
      child: Container(
        width: buttonWidth,
        margin: EdgeInsets.only(
          right:
              index < widget.dates.length - 1 ? (widget.itemSpacing ?? 16) : 0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: buttonPadding * 0.75,
          vertical: buttonPadding * 0.5,
        ),
        decoration: _buildDateItemDecoration(isSelected),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Yellow dot indicator for today when not selected
            if (isToday && !isSelected) _buildTodayIndicator(),
            if (isToday && !isSelected) SizedBox(height: baseSize * 0.15),
            _buildDateNumber(dateInfo.date.day, isSelected),
            SizedBox(height: baseSize * 0.13), // Proportional spacing
            _buildWeekdayText(dateInfo, isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayIndicator() {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: Color(0xFFEAB308), // Same yellow color as selected day
        shape: BoxShape.circle,
      ),
    );
  }

  BoxDecoration _buildDateItemDecoration(bool isSelected) {
    return BoxDecoration(
      color: isSelected ? Colors.white : Colors.transparent,
      border:
          isSelected
              ? Border.all(color: Colors.grey.withValues(alpha: 0.2))
              : null,
      boxShadow:
          isSelected
              ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
              : null,
    );
  }

  Widget _buildDateNumber(int day, bool isSelected) {
    return Text(
      day.toString(),
      style: TextStyle(
        fontSize: widget.dateNumberFontSize ?? 15,
        fontWeight: FontWeight.w600,
        color: isSelected ? Colors.black : AppColors.textTertiary,
      ),
    );
  }

  Widget _buildWeekdayText(DateInfo dateInfo, bool isSelected) {
    return Text(
      isSelected ? dateInfo.weekday.toUpperCase() : dateInfo.shortWeekday,
      style: TextStyle(
        fontSize: widget.weekdayFontSize ?? 10,
        fontWeight: FontWeight.w500,
        color: isSelected ? const Color(0xFFEAB308) : AppColors.textTertiary,
      ),
    );
  }

  Widget _buildSelectedDateInfo(BuildContext context) {
    return DateHeader(
      date: selectedDate.date,
      conversationCount: widget.conversationCount,
      horizontalPadding: 8,
      selectedDateFontSize: widget.selectedDateFontSize ?? 16,
      conversationCountFontSize: widget.conversationCountFontSize ?? 14,
    );
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _handleDateSelection(DateInfo dateInfo) {
    if (!_isSameDate(dateInfo.date, selectedDate.date)) {
      setState(() {
        selectedDate = dateInfo;
      });
      widget.onDateSelected?.call(dateInfo);
    }
  }
}

// Factory class to create date ranges
class DateCalendarFactory {
  static List<DateInfo> createWeekDates({DateTime? startDate}) {
    final start = startDate ?? DateTime.now().subtract(const Duration(days: 2));
    final dates = <DateInfo>[];

    for (int i = 0; i < 7; i++) {
      final date = start.add(Duration(days: i));
      dates.add(
        DateInfo(
          date: date,
          weekday: _getWeekdayAbbreviation(date.weekday),
          shortWeekday: _getShortWeekday(date.weekday),
          fullWeekday: _getFullWeekday(date.weekday),
        ),
      );
    }

    return dates;
  }

  static String _getWeekdayAbbreviation(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  static String _getShortWeekday(int weekday) {
    const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return weekdays[weekday - 1];
  }

  static String _getFullWeekday(int weekday) {
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
}

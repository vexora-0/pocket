import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/conversation.dart';

class DateCalendar extends StatefulWidget {
  final List<DateInfo> dates;
  final DateInfo? initialSelectedDate;
  final Function(DateInfo selectedDate)? onDateSelected;
  final int conversationCount;

  const DateCalendar({
    super.key,
    required this.dates,
    this.initialSelectedDate,
    this.onDateSelected,
    this.conversationCount = 0,
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

    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive values
    double horizontalPadding = 13.0;
    double verticalSpacing = 16.0;

    if (screenWidth >= 900) {
      horizontalPadding = 32.0;
      verticalSpacing = 24.0;
    } else if (screenWidth >= 600) {
      horizontalPadding = 24.0;
      verticalSpacing = 20.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      horizontalPadding = (13.0 * scaleFactor).clamp(13.0, 20.0);
      verticalSpacing = (16.0 * scaleFactor).clamp(16.0, 20.0);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: verticalSpacing),
          _buildDateScroller(),
          SizedBox(height: verticalSpacing),
          _buildSelectedDateInfo(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive font size
    double fontSize = 20.0; // headlineSmall default

    if (screenWidth >= 900) {
      fontSize = 28.0;
    } else if (screenWidth >= 600) {
      fontSize = 24.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      fontSize = (20.0 * scaleFactor).clamp(20.0, 24.0);
    }

    return Text(
      'Your conversations',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        fontSize: fontSize,
      ),
    );
  }

  Widget _buildDateScroller() {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive height
    double scrollerHeight = 50.0;

    if (screenWidth >= 900) {
      scrollerHeight = 66.0;
    } else if (screenWidth >= 600) {
      scrollerHeight = 58.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      scrollerHeight = (50.0 * scaleFactor).clamp(50.0, 58.0);
    }

    return SizedBox(
      height: scrollerHeight,
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
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive values
    double rightMargin = 16.0;
    double horizontalPadding = 12.0;
    double verticalPadding = 4.0;
    double itemSpacing = 2.0;

    if (screenWidth >= 900) {
      rightMargin = 22.0;
      horizontalPadding = 16.0;
      verticalPadding = 8.0;
      itemSpacing = 4.0;
    } else if (screenWidth >= 600) {
      rightMargin = 20.0;
      horizontalPadding = 14.0;
      verticalPadding = 6.0;
      itemSpacing = 3.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      rightMargin = (16.0 * scaleFactor).clamp(16.0, 20.0);
      horizontalPadding = (12.0 * scaleFactor).clamp(12.0, 14.0);
      verticalPadding = (4.0 * scaleFactor).clamp(4.0, 6.0);
      itemSpacing = (2.0 * scaleFactor).clamp(2.0, 3.0);
    }

    return GestureDetector(
      onTap: () => _handleDateSelection(dateInfo),
      child: Container(
        margin: EdgeInsets.only(
          right: index < widget.dates.length - 1 ? rightMargin : 0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: _buildDateItemDecoration(isSelected),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDateNumber(dateInfo.date.day, isSelected),
            SizedBox(height: itemSpacing),
            _buildWeekdayText(dateInfo, isSelected),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDateItemDecoration(bool isSelected) {
    return BoxDecoration(
      color: isSelected ? Colors.white : Colors.transparent,
      border:
          isSelected ? Border.all(color: Colors.grey.withOpacity(0.2)) : null,
      boxShadow:
          isSelected
              ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
              : null,
    );
  }

  Widget _buildDateNumber(int day, bool isSelected) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive font size
    double fontSize = 15.0;

    if (screenWidth >= 900) {
      fontSize = 20.0;
    } else if (screenWidth >= 600) {
      fontSize = 18.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      fontSize = (15.0 * scaleFactor).clamp(15.0, 18.0);
    }

    return Text(
      day.toString(),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: isSelected ? Colors.black : AppColors.textTertiary,
      ),
    );
  }

  Widget _buildWeekdayText(DateInfo dateInfo, bool isSelected) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive font size
    double fontSize = 10.0;

    if (screenWidth >= 900) {
      fontSize = 14.0;
    } else if (screenWidth >= 600) {
      fontSize = 12.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      fontSize = (10.0 * scaleFactor).clamp(10.0, 12.0);
    }

    return Text(
      isSelected ? dateInfo.weekday.toUpperCase() : dateInfo.shortWeekday,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: isSelected ? const Color(0xFFEAB308) : AppColors.textTertiary,
      ),
    );
  }

  Widget _buildSelectedDateInfo(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive padding
    double topPadding = 18.0;
    double horizontalPadding = 8.0;
    double bottomPadding = 8.0;

    if (screenWidth >= 900) {
      topPadding = 28.0;
      horizontalPadding = 16.0;
      bottomPadding = 16.0;
    } else if (screenWidth >= 600) {
      topPadding = 24.0;
      horizontalPadding = 12.0;
      bottomPadding = 12.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      topPadding = (18.0 * scaleFactor).clamp(18.0, 24.0);
      horizontalPadding = (8.0 * scaleFactor).clamp(8.0, 12.0);
      bottomPadding = (8.0 * scaleFactor).clamp(8.0, 12.0);
    }

    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        right: horizontalPadding,
        left: horizontalPadding,
        bottom: bottomPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSelectedDateDisplay(context),
          _buildConversationCountDisplay(context),
        ],
      ),
    );
  }

  Widget _buildSelectedDateDisplay(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive font sizes and spacing
    double primaryFontSize = 16.0;
    double secondaryFontSize = 14.0;
    double spacing = 6.0;

    if (screenWidth >= 900) {
      primaryFontSize = 20.0;
      secondaryFontSize = 18.0;
      spacing = 10.0;
    } else if (screenWidth >= 600) {
      primaryFontSize = 18.0;
      secondaryFontSize = 16.0;
      spacing = 8.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      primaryFontSize = (16.0 * scaleFactor).clamp(16.0, 18.0);
      secondaryFontSize = (14.0 * scaleFactor).clamp(14.0, 16.0);
      spacing = (6.0 * scaleFactor).clamp(6.0, 8.0);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '${selectedDate.fullWeekday},',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w800,
            fontSize: primaryFontSize,
          ),
        ),
        SizedBox(width: spacing),
        Text(
          _formatSelectedDate(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: secondaryFontSize,
          ),
        ),
      ],
    );
  }

  Widget _buildConversationCountDisplay(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive font size and icon size
    double fontSize = 14.0;
    double iconSize = 16.0;
    double spacing = 4.0;

    if (screenWidth >= 900) {
      fontSize = 18.0;
      iconSize = 20.0;
      spacing = 6.0;
    } else if (screenWidth >= 600) {
      fontSize = 16.0;
      iconSize = 18.0;
      spacing = 5.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      fontSize = (14.0 * scaleFactor).clamp(14.0, 16.0);
      iconSize = (16.0 * scaleFactor).clamp(16.0, 18.0);
      spacing = (4.0 * scaleFactor).clamp(4.0, 5.0);
    }

    return Row(
      children: [
        Text(
          widget.conversationCount.toString(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
          ),
        ),
        SizedBox(width: spacing),
        Icon(
          Icons.chevron_right,
          size: iconSize,
          color: AppColors.textSecondary,
        ),
      ],
    );
  }

  String _formatSelectedDate() {
    final months = [
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

    final month = months[selectedDate.date.month - 1];
    final day = selectedDate.date.day;
    final year = selectedDate.date.year.toString().substring(2);

    return '$month $day \'$year';
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


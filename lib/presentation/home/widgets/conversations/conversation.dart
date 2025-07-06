import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../data/models/conversation.dart';
import 'date_calendar.dart';
import 'conversation_card.dart';
import 'older_conversation.dart';

class ConversationSection extends StatefulWidget {
  final List<DateInfo> dates;
  final List<Conversation> conversations;
  final List<Conversation> olderConversations;
  final DateTime? olderConversationDate;
  final Function(DateInfo selectedDate)? onDateSelected;
  final Function(Conversation conversation)? onConversationTap;
  final VoidCallback? onOlderConversationTap;

  const ConversationSection({
    super.key,
    required this.dates,
    required this.conversations,
    required this.olderConversations,
    this.olderConversationDate,
    this.onDateSelected,
    this.onConversationTap,
    this.onOlderConversationTap,
  });

  @override
  State<ConversationSection> createState() => _ConversationSectionState();
}

class _ConversationSectionState extends State<ConversationSection> {
  late DateInfo selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate =
        widget.dates.isNotEmpty ? widget.dates.first : _createDefaultDate();
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

  void _handleDateSelection(DateInfo dateInfo) {
    setState(() {
      selectedDate = dateInfo;
    });
    widget.onDateSelected?.call(dateInfo);
  }

  @override
  Widget build(BuildContext context) {
    final deviceInfo = context.responsive;

    return Column(
      children: [
        _buildDateCalendar(deviceInfo),
        SizedBox(height: deviceInfo.dateCalendarToConversationsSpacing),
        _buildConversationsList(deviceInfo),
        SizedBox(height: deviceInfo.olderConversationSectionSpacing),
        _buildOlderConversations(deviceInfo),
        SizedBox(
          height: deviceInfo.headerPadding,
        ), // Add padding below older conversations
      ],
    );
  }

  Widget _buildDateCalendar(ResponsiveConfiguration deviceInfo) {
    return DateCalendar(
      dates: widget.dates,
      conversationCount: widget.conversations.length,
      horizontalPadding: deviceInfo.headerPadding,
      scrollerHeight: deviceInfo.dateCalendarHeight,
      headerFontSize: deviceInfo.titleFontSize * 0.75,
      dateNumberFontSize: deviceInfo.greetingFontSize * 1.07,
      weekdayFontSize: deviceInfo.greetingFontSize * 0.71,
      selectedDateFontSize: deviceInfo.greetingFontSize * 1.14,
      conversationCountFontSize: deviceInfo.greetingFontSize,
      itemSpacing: deviceInfo.categoryTabPadding + 4,
      headerToScrollerSpacing: deviceInfo.dateCalendarHeaderToScrollerSpacing,
      scrollerToSelectedInfoSpacing:
          deviceInfo.dateCalendarScrollerToSelectedInfoSpacing,
      onDateSelected: _handleDateSelection,
    );
  }

  Widget _buildConversationsList(ResponsiveConfiguration deviceInfo) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (deviceInfo.isTablet) {
          return _buildGridLayout(widget.conversations, deviceInfo);
        } else {
          return _buildHorizontalScrollLayout(widget.conversations, deviceInfo);
        }
      },
    );
  }

  Widget _buildHorizontalScrollLayout(
    List<Conversation> conversations,
    ResponsiveConfiguration deviceInfo,
  ) {
    final conversationColumns = _chunkConversations(
      conversations,
      deviceInfo.cardsPerColumn,
    );

    return SizedBox(
      height: deviceInfo.listHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: deviceInfo.horizontalPadding),
        itemCount: conversationColumns.length,
        itemBuilder: (context, columnIndex) {
          final columnConversations = conversationColumns[columnIndex];
          return _buildConversationColumn(
            context,
            columnConversations,
            columnIndex,
            conversationColumns.length,
            deviceInfo,
          );
        },
      ),
    );
  }

  Widget _buildGridLayout(
    List<Conversation> conversations,
    ResponsiveConfiguration deviceInfo,
  ) {
    return Container(
      height: deviceInfo.listHeight,
      padding: EdgeInsets.symmetric(horizontal: deviceInfo.horizontalPadding),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: deviceInfo.gridColumns,
          childAspectRatio: deviceInfo.cardAspectRatio,
          crossAxisSpacing: 20,
          mainAxisSpacing: deviceInfo.cardVerticalSpacing,
        ),
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ConversationCard(
            conversation: conversation,
            subtitleMaxWidth: deviceInfo.subtitleMaxWidth,
            thumbnailWidth: deviceInfo.thumbnailWidth,
            thumbnailHeight: deviceInfo.thumbnailHeight,
            cardPadding: deviceInfo.cardPadding,
            contentSpacing: deviceInfo.contentSpacing,
            titleSubtitleSpacing: deviceInfo.titleSubtitleSpacing,
            onTap: () => widget.onConversationTap?.call(conversation),
          );
        },
      ),
    );
  }

  Widget _buildConversationColumn(
    BuildContext context,
    List<Conversation> conversations,
    int columnIndex,
    int totalColumns,
    ResponsiveConfiguration deviceInfo,
  ) {
    final isLastColumn = columnIndex == totalColumns - 1;

    return Container(
      width: deviceInfo.columnWidth,
      margin: EdgeInsets.only(
        right: isLastColumn ? 0 : deviceInfo.columnSpacing,
      ),
      child: Column(
        children:
            conversations.asMap().entries.expand((entry) {
              final index = entry.key;
              final conversation = entry.value;
              final widgets = <Widget>[
                SizedBox(
                  height: deviceInfo.cardHeight,
                  child: ConversationCard(
                    conversation: conversation,
                    subtitleMaxWidth: deviceInfo.subtitleMaxWidth,
                    thumbnailWidth: deviceInfo.thumbnailWidth,
                    thumbnailHeight: deviceInfo.thumbnailHeight,
                    cardPadding: deviceInfo.cardPadding,
                    contentSpacing: deviceInfo.contentSpacing,
                    titleSubtitleSpacing: deviceInfo.titleSubtitleSpacing,
                    onTap: () => widget.onConversationTap?.call(conversation),
                  ),
                ),
              ];

              if (index < conversations.length - 1) {
                widgets.add(
                  Container(
                    height: 1,
                    margin: EdgeInsets.only(
                      left: deviceInfo.dividerLeftMargin,
                      right: 12,
                      top: deviceInfo.cardVerticalSpacing,
                      bottom: deviceInfo.cardVerticalSpacing,
                    ),
                    color: const Color(0xFFE5E7EB),
                  ),
                );
              }
              return widgets;
            }).toList(),
      ),
    );
  }

  Widget _buildOlderConversations(ResponsiveConfiguration deviceInfo) {
    if (widget.olderConversations.isEmpty) {
      return const SizedBox.shrink();
    }

    final olderDate = selectedDate.date.subtract(const Duration(days: 1));

    return OlderConversation(
      conversations: widget.olderConversations,
      date: olderDate,
      cardWidth: deviceInfo.olderConversationCardWidth,
      cardHeight: deviceInfo.olderConversationCardHeight * 1.4,
      horizontalPadding: deviceInfo.headerPadding,
      cardSpacing: deviceInfo.olderConversationCardSpacing * 0.1,
      titleFontSize: deviceInfo.olderConversationTitleFontSize,
      subtitleFontSize: deviceInfo.olderConversationSubtitleFontSize,
      iconSize: deviceInfo.olderConversationIconSize,
      titleIconSpacing: deviceInfo.olderConversationTitleIconSpacing,
      titleSubtitleSpacing: deviceInfo.olderConversationTitleSubtitleSpacing,
      gradientToContentSpacing:
          deviceInfo.olderConversationGradientToContentSpacing,
      selectedDateFontSize: deviceInfo.greetingFontSize * 1.14,
      conversationCountFontSize: deviceInfo.greetingFontSize,
      onTap: widget.onOlderConversationTap,
    );
  }

  List<List<Conversation>> _chunkConversations(
    List<Conversation> conversations,
    int chunkSize,
  ) {
    final chunks = <List<Conversation>>[];
    for (int i = 0; i < conversations.length; i += chunkSize) {
      final end =
          (i + chunkSize < conversations.length)
              ? i + chunkSize
              : conversations.length;
      chunks.add(conversations.sublist(i, end));
    }
    return chunks;
  }
}

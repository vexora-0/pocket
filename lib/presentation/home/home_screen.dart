import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/colors.dart';
import '../../data/models/conversation.dart';
import '../../data/datasources/mock_data_source.dart';
import '../../utils/device_utils.dart';
import 'widgets/category_tabs.dart';
import 'widgets/date_calendar.dart';
import 'widgets/conversation_card.dart';
import 'widgets/player/player.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final categories = MockDataSource.getCategories();
    final dates = MockDataSource.getDates();
    final conversations = MockDataSource.getConversations();
    final miniPlayerData = MockDataSource.getMiniPlayerData();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 16, 17),
      body: Player(
        child: _buildMainContent(
          categories,
          dates,
          conversations,
          miniPlayerData,
        ),
      ),
    );
  }

  Widget _buildMainContent(
    List<ConversationType> categories,
    List<DateInfo> dates,
    List<Conversation> conversations,
    MiniPlayerData? miniPlayerData,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceInfo = DeviceUtils.getDeviceInfo(screenWidth, screenHeight);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 25,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Header - Fixed with top padding
            SafeArea(bottom: false, child: _buildHeader(context)),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: deviceInfo.headerToCategoryTabsSpacing),
                    _buildCategoryTabs(categories),
                    SizedBox(height: deviceInfo.categoryTabsToDividerSpacing),
                    _buildDivider(),
                    SizedBox(height: deviceInfo.dividerToDateCalendarSpacing),
                    _buildDateCalendar(dates, conversations.length),
                    SizedBox(
                      height: deviceInfo.dateCalendarToConversationsSpacing,
                    ),
                    _buildConversationsList(conversations),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header - Moving content higher by reducing padding
  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceInfo = DeviceUtils.getDeviceInfo(screenWidth, screenHeight);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        deviceInfo.headerPadding,
        deviceInfo.topSafeAreaPadding +
            deviceInfo.headerVerticalPadding, // Add top padding
        deviceInfo.headerPadding,
        deviceInfo.headerVerticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopRow(context, deviceInfo),
          _buildGreeting(context, deviceInfo),
        ],
      ),
    );
  }

  Widget _buildTopRow(BuildContext context, DeviceInfo deviceInfo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pocket',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            fontSize: deviceInfo.titleFontSize,
          ),
        ),
        _buildHeaderIcons(deviceInfo),
      ],
    );
  }

  Widget _buildHeaderIcons(DeviceInfo deviceInfo) {
    return Row(
      children: [
        _buildIconButton('assets/icons/search.svg', () {}, deviceInfo),
        const SizedBox(width: 8),
        _buildIconButton('assets/icons/person.svg', () {}, deviceInfo),
      ],
    );
  }

  Widget _buildIconButton(
    String iconPath,
    VoidCallback onTap,
    DeviceInfo deviceInfo,
  ) {
    return Container(
      width: deviceInfo.iconContainerSize,
      height: deviceInfo.iconContainerSize,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 238, 238),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          iconPath,
          width: deviceInfo.iconSize,
          height: deviceInfo.iconSize,
        ),
        onPressed: onTap,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, DeviceInfo deviceInfo) {
    return Transform.translate(
      offset: const Offset(0, -2),
      child: Text(
        MockDataSource.getGreetingMessage(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color.fromARGB(255, 138, 144, 153),
          fontWeight: FontWeight.w600,
          fontSize: deviceInfo.greetingFontSize,
        ),
      ),
    );
  }

  // Using existing widgets
  Widget _buildCategoryTabs(List<ConversationType> categories) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceInfo = DeviceUtils.getDeviceInfo(screenWidth, screenHeight);

    return CategoryTabs(
      categories: categories,
      height:
          deviceInfo.categoryTabHeight +
          36, // Base height + responsive adjustment
      horizontalPadding: deviceInfo.headerPadding,
      itemSpacing: deviceInfo.categoryTabPadding,
      fontSize: deviceInfo.greetingFontSize,
      iconWidth: deviceInfo.categoryTabIconWidth,
      iconHeight: deviceInfo.categoryTabIconHeight,
      onCategorySelected: (category, index) {
        _handleCategorySelection(category, index);
      },
    );
  }

  Widget _buildDivider() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceInfo = DeviceUtils.getDeviceInfo(screenWidth, screenHeight);

    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: deviceInfo.headerPadding),
      color: const Color(0xFFE5E7EB),
    );
  }

  Widget _buildDateCalendar(List<DateInfo> dates, int conversationCount) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceInfo = DeviceUtils.getDeviceInfo(screenWidth, screenHeight);

    return DateCalendar(
      dates: dates,
      conversationCount: conversationCount,
      horizontalPadding: deviceInfo.headerPadding,
      scrollerHeight: deviceInfo.dateCalendarHeight,
      headerFontSize: deviceInfo.titleFontSize * 0.75, // Proportional to title
      dateNumberFontSize:
          deviceInfo.greetingFontSize * 1.07, // Slightly larger than greeting
      weekdayFontSize:
          deviceInfo.greetingFontSize * 0.71, // Smaller than greeting
      selectedDateFontSize:
          deviceInfo.greetingFontSize * 1.14, // Larger than greeting
      conversationCountFontSize: deviceInfo.greetingFontSize,
      itemSpacing:
          deviceInfo.categoryTabPadding +
          4, // Slightly larger than category spacing
      headerToScrollerSpacing: deviceInfo.dateCalendarHeaderToScrollerSpacing,
      scrollerToSelectedInfoSpacing:
          deviceInfo.dateCalendarScrollerToSelectedInfoSpacing,
      onDateSelected: (selectedDate) {
        _handleDateSelection(selectedDate);
      },
    );
  }

  Widget _buildConversationsList(List<Conversation> conversations) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        // Determine device type and responsive values
        final deviceInfo = DeviceUtils.getDeviceInfo(screenWidth, screenHeight);

        // For tablets and large screens, use grid layout
        if (deviceInfo.isTablet) {
          return _buildGridLayout(conversations, deviceInfo);
        } else {
          // For phones, use horizontal scroll layout
          return _buildHorizontalScrollLayout(conversations, deviceInfo);
        }
      },
    );
  }

  Widget _buildHorizontalScrollLayout(
    List<Conversation> conversations,
    DeviceInfo deviceInfo,
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
    DeviceInfo deviceInfo,
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
            onTap: () => _handleConversationTap(conversation),
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
    DeviceInfo deviceInfo,
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
                    onTap: () => _handleConversationTap(conversation),
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

  // Helper methods
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

  // Event handlers
  void _handleCategorySelection(ConversationType category, int index) {
    debugPrint('Selected category: ${category.title}');
  }

  void _handleDateSelection(DateInfo selectedDate) {
    debugPrint('Selected date: ${selectedDate.date}');
  }

  void _handleConversationTap(Conversation conversation) {
    debugPrint('Tapped conversation: ${conversation.title}');
  }
}

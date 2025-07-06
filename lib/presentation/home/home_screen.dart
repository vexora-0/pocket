import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/colors.dart';
import '../../core/responsive/responsive.dart';
import '../../data/models/conversation.dart';
import '../../data/datasources/mock_data_source.dart';
import 'widgets/category_tabs.dart';
import 'widgets/conversations/conversation.dart';
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
    final olderConversations = MockDataSource.getOlderConversations();
    final miniPlayerData = MockDataSource.getMiniPlayerData();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 16, 17),
      body: Player(
        child: _buildMainContent(
          categories,
          dates,
          conversations,
          olderConversations,
          miniPlayerData,
        ),
      ),
    );
  }

  Widget _buildMainContent(
    List<ConversationType> categories,
    List<DateInfo> dates,
    List<Conversation> conversations,
    List<Conversation> olderConversations,
    MiniPlayerData? miniPlayerData,
  ) {
    final deviceInfo = context.responsive;

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
                    ConversationSection(
                      dates: dates,
                      conversations: conversations,
                      olderConversations: olderConversations,
                      olderConversationDate: DateTime.now().subtract(
                        const Duration(days: 1),
                      ),
                      onDateSelected: _handleDateSelection,
                      onConversationTap: _handleConversationTap,
                      onOlderConversationTap: _handleOlderConversationTap,
                    ),
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
    final deviceInfo = context.responsive;

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

  Widget _buildTopRow(
    BuildContext context,
    ResponsiveConfiguration deviceInfo,
  ) {
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

  Widget _buildHeaderIcons(ResponsiveConfiguration deviceInfo) {
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
    ResponsiveConfiguration deviceInfo,
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

  Widget _buildGreeting(
    BuildContext context,
    ResponsiveConfiguration deviceInfo,
  ) {
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
    final deviceInfo = context.responsive;

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
    final deviceInfo = context.responsive;

    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: deviceInfo.headerPadding),
      color: const Color(0xFFE5E7EB),
    );
  }

  // Helper methods moved to ConversationSection widget

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

  // _buildOlderConversations method moved to ConversationSection widget

  void _handleOlderConversationTap() {
    debugPrint('Tapped older conversation');
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/colors.dart';
import '../../data/models/conversation.dart';
import '../../data/datasources/mock_data_source.dart';
import '../../utils/color_utils.dart';
import 'widgets/category_tabs.dart';
import 'widgets/date_calendar.dart';
import 'widgets/conversation_card.dart';
import 'widgets/mini_player.dart';

// DeviceInfo class for responsive configuration
class DeviceInfo {
  final bool isTablet;
  final double columnWidth;
  final double cardHeight;
  final double listHeight;
  final int cardsPerColumn;
  final int gridColumns;
  final double cardAspectRatio;
  final double subtitleMaxWidth;
  final double horizontalPadding;
  final double columnSpacing;
  final double dividerLeftMargin;
  final double dividerSpacing;
  final double thumbnailWidth;
  final double thumbnailHeight;
  final EdgeInsets cardPadding;
  final double contentSpacing;
  final double titleSubtitleSpacing;
  final double cardVerticalSpacing;

  const DeviceInfo({
    required this.isTablet,
    required this.columnWidth,
    required this.cardHeight,
    required this.listHeight,
    required this.cardsPerColumn,
    required this.gridColumns,
    required this.cardAspectRatio,
    required this.subtitleMaxWidth,
    required this.horizontalPadding,
    required this.columnSpacing,
    required this.dividerLeftMargin,
    required this.dividerSpacing,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.cardPadding,
    required this.contentSpacing,
    required this.titleSubtitleSpacing,
    required this.cardVerticalSpacing,
  });
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  double _playerPosition = 0.15; // Initial position (15% of screen)
  AnimationController? _bounceController;
  Animation<double>? _bounceAnimation;
  bool _hasBouncedOnExpansion = false;

  @override
  void initState() {
    super.initState();

    // Initialize bounce animation controller
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bounceController!, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _bounceController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = MockDataSource.getCategories();
    final dates = MockDataSource.getDates();
    final conversations = MockDataSource.getConversations();
    final miniPlayerData = MockDataSource.getMiniPlayerData();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 16, 17),
      body: AnimatedBuilder(
        animation: _bounceAnimation ?? const AlwaysStoppedAnimation(0.0),
        builder: (context, child) {
          return Stack(
            children: [
              // Main Home Content
              _buildMainContent(
                categories,
                dates,
                conversations,
                miniPlayerData,
              ),

              // Mini Player Overlay
              if (miniPlayerData != null)
                MiniPlayer(
                  playerData: miniPlayerData,
                  onPlayPause: _handlePlayPause,
                  bounceProgress:
                      _bounceAnimation?.value ??
                      0.0, // Safe access with null check
                  onPositionChanged: (position) {
                    setState(() {
                      // Clamp and round the position to avoid floating-point precision issues
                      _playerPosition = (position * 1000).round() / 1000;
                      debugPrint(
                        'Player position: $_playerPosition, blocking: ${_playerPosition > 0.16}',
                      );
                      _handlePlayerPositionChange(_playerPosition);
                    });
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  void _handlePlayerPositionChange(double position) {
    // Trigger bounce when reaching full expansion (85%)
    if (position >= 0.84 && !_hasBouncedOnExpansion) {
      _hasBouncedOnExpansion = true;
      _bounceController?.forward();
    }

    // Reset bounce flag when minimized
    if (position <= 0.2) {
      _hasBouncedOnExpansion = false;
      _bounceController?.reset();
    }
  }

  Widget _buildMainContent(
    List<ConversationType> categories,
    List<DateInfo> dates,
    List<Conversation> conversations,
    MiniPlayerData? miniPlayerData,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Apply bounce effect to available height - with null safety
    final bounceValue = _bounceAnimation?.value ?? 0.0;
    final baseBounce = bounceValue * 0.02; // 2% bounce amplitude
    final bounceOffset = (1 - (baseBounce * (1 - bounceValue * 2).abs()));

    final availableHeight =
        miniPlayerData != null
            ? screenHeight * (1 - _playerPosition) * bounceOffset
            : screenHeight;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: availableHeight,
      child: Stack(
        children: [
          // Main content container
          Container(
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
                  // Header - Fixed
                  SafeArea(bottom: false, child: _buildHeader(context)),

                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildCategoryTabs(categories),
                          _buildDivider(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _buildDateCalendar(
                              dates,
                              conversations.length,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 24),
                            child: _buildConversationsList(conversations),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // White overlay that increases opacity as player expands
          if (miniPlayerData != null) _buildWhiteOverlay(),
        ],
      ),
    );
  }

  Widget _buildWhiteOverlay() {
    // Calculate overlay opacity based on player position (0.15 to 0.85)
    final overlayProgress = ((_playerPosition - 0.15) / (0.85 - 0.15)).clamp(
      0.0,
      1.0,
    );
    final overlayOpacity = overlayProgress;

    // Check if player is at maximum height (85%)
    final isAtMaxHeight = _playerPosition >= 0.80;

    // Block interactions when significantly dragged (with tolerance for floating point precision)
    final shouldBlockInteractions = _playerPosition > 0.16;

    return IgnorePointer(
      ignoring: !shouldBlockInteractions, // Only block when dragging starts
      child: AnimatedOpacity(
        opacity: overlayOpacity,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: overlayOpacity),
            borderRadius: BorderRadius.circular(24),
          ),
          child: isAtMaxHeight ? _buildSwipeDownContent() : null,
        ),
      ),
    );
  }

  Widget _buildSwipeDownContent() {
    return Center(
      child: AnimatedSlide(
        offset:
            _playerPosition >= 0.80
                ? const Offset(0, 0) // Final position
                : const Offset(0, -1), // Start position (slide down from above)
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: _playerPosition >= 0.84 ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 47,
            ), // Move content down from center
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Scroll pointer SVG
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: SvgPicture.asset(
                    'assets/icons/scroll.svg',
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ), // Changed from height to width for horizontal spacing
                // Text content
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Swipe down',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      TextSpan(
                        text: ' to go home',
                        style: TextStyle(
                          color: Colors.black.withValues(
                            alpha: 0.5,
                          ), // rgba(0, 0, 0, 0.50)
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header - Responsive padding based on screen size
  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive padding
    double horizontalPadding = 13.0;
    double verticalPadding = 8.0;

    if (screenWidth >= 900) {
      // Large tablets and desktops
      horizontalPadding = 32.0;
      verticalPadding = 20.0;
    } else if (screenWidth >= 600) {
      // Small tablets and large phones (landscape)
      horizontalPadding = 24.0;
      verticalPadding = 16.0;
    } else if (screenWidth >= 430) {
      // Large phones
      final scaleFactor = screenWidth / 393;
      horizontalPadding = (13.0 * scaleFactor).clamp(13.0, 20.0);
      verticalPadding = (8.0 * scaleFactor).clamp(8.0, 14.0);
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        verticalPadding,
        horizontalPadding,
        verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildTopRow(context), _buildGreeting(context)],
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive font size
    double fontSize = 24.0;
    if (screenWidth >= 900) {
      fontSize = 32.0;
    } else if (screenWidth >= 600) {
      fontSize = 28.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      fontSize = (24.0 * scaleFactor).clamp(24.0, 28.0);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pocket',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            fontSize: fontSize,
          ),
        ),
        _buildHeaderIcons(),
      ],
    );
  }

  Widget _buildHeaderIcons() {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive spacing
    double spacing = 8.0;
    if (screenWidth >= 900) {
      spacing = 12.0;
    } else if (screenWidth >= 600) {
      spacing = 10.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      spacing = (8.0 * scaleFactor).clamp(8.0, 10.0);
    }

    return Row(
      children: [
        _buildIconButton('assets/icons/search.svg', () {}),
        SizedBox(width: spacing),
        _buildIconButton('assets/icons/person.svg', () {}),
      ],
    );
  }

  Widget _buildIconButton(String iconPath, VoidCallback onTap) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive icon button size
    double containerSize = 32.0;
    double iconSize = 16.0;

    if (screenWidth >= 900) {
      containerSize = 40.0;
      iconSize = 20.0;
    } else if (screenWidth >= 600) {
      containerSize = 36.0;
      iconSize = 18.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      containerSize = (32.0 * scaleFactor).clamp(32.0, 36.0);
      iconSize = (16.0 * scaleFactor).clamp(16.0, 18.0);
    }

    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 238, 238),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        icon: SvgPicture.asset(iconPath, width: iconSize, height: iconSize),
        onPressed: onTap,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive font size and spacing
    double fontSize = 14.0;
    double offsetY = -2.0;

    if (screenWidth >= 900) {
      fontSize = 18.0;
      offsetY = -4.0;
    } else if (screenWidth >= 600) {
      fontSize = 16.0;
      offsetY = -3.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      fontSize = (14.0 * scaleFactor).clamp(14.0, 16.0);
      offsetY = (-2.0 * scaleFactor).clamp(-2.0, -3.0);
    }

    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Text(
        MockDataSource.getGreetingMessage(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color.fromARGB(255, 138, 144, 153),
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),
      ),
    );
  }

  // Using existing widgets
  Widget _buildCategoryTabs(List<ConversationType> categories) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: CategoryTabs(
        categories: categories,
        onCategorySelected: (category, index) {
          _handleCategorySelection(category, index);
        },
      ),
    );
  }

  Widget _buildDivider() {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive margin
    double horizontalMargin = 13.0;
    double verticalMargin = 20.0;

    if (screenWidth >= 900) {
      horizontalMargin = 32.0;
      verticalMargin = 32.0;
    } else if (screenWidth >= 600) {
      horizontalMargin = 24.0;
      verticalMargin = 28.0;
    } else if (screenWidth >= 430) {
      final scaleFactor = screenWidth / 393;
      horizontalMargin = (13.0 * scaleFactor).clamp(13.0, 20.0);
      verticalMargin = (20.0 * scaleFactor).clamp(20.0, 24.0);
    }

    return Container(
      height: 1,
      margin: EdgeInsets.fromLTRB(
        horizontalMargin,
        verticalMargin,
        horizontalMargin,
        verticalMargin,
      ),
      color: const Color(0xFFE5E7EB),
    );
  }

  Widget _buildDateCalendar(List<DateInfo> dates, int conversationCount) {
    return DateCalendar(
      dates: dates,
      conversationCount: conversationCount,
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
        final deviceInfo = _getDeviceInfo(screenWidth, screenHeight);

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

  DeviceInfo _getDeviceInfo(double screenWidth, double screenHeight) {
    // Define breakpoints with better scaling for larger devices
    if (screenWidth >= 900) {
      // Large tablets and desktops
      return DeviceInfo(
        isTablet: true,
        columnWidth: screenWidth * 0.45,
        cardHeight: 110,
        listHeight: 480,
        cardsPerColumn: 4,
        gridColumns: 2,
        cardAspectRatio: 4.0,
        subtitleMaxWidth: 220,
        horizontalPadding: 32.0,
        columnSpacing: 28.0,
        dividerLeftMargin: 192,
        dividerSpacing: 10,
        thumbnailWidth: 160,
        thumbnailHeight: 95,
        cardPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        contentSpacing: 22.0,
        titleSubtitleSpacing: 10.0,
        cardVerticalSpacing: 16.0,
      );
    } else if (screenWidth >= 600) {
      // Small tablets and large phones (landscape)
      return DeviceInfo(
        isTablet: false,
        columnWidth: screenWidth * 0.75,
        cardHeight: 100,
        listHeight: 420,
        cardsPerColumn: 4,
        gridColumns: 1,
        cardAspectRatio: 3.5,
        subtitleMaxWidth: 200,
        horizontalPadding: 24.0,
        columnSpacing: 24.0,
        dividerLeftMargin: 172,
        dividerSpacing: 9,
        thumbnailWidth: 140,
        thumbnailHeight: 88,
        cardPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        contentSpacing: 18.0,
        titleSubtitleSpacing: 8.0,
        cardVerticalSpacing: 12.0,
      );
    } else if (screenWidth >= 430) {
      // Large phones (iPhone Pro Max, Samsung S24 Ultra, etc.)
      final scaleFactor = screenWidth / 393; // 393 is our baseline width
      return DeviceInfo(
        isTablet: false,
        columnWidth: screenWidth * 0.82,
        cardHeight: (88 * scaleFactor).clamp(88, 100),
        listHeight: (340 * scaleFactor).clamp(340, 390),
        cardsPerColumn: 3,
        gridColumns: 1,
        cardAspectRatio: 3.0,
        subtitleMaxWidth: (150 * scaleFactor).clamp(150, 180),
        horizontalPadding: (16.0 * scaleFactor).clamp(16.0, 22.0),
        columnSpacing: (18.0 * scaleFactor).clamp(18.0, 22.0),
        dividerLeftMargin: (152 * scaleFactor).clamp(152, 170),
        dividerSpacing: (6 * scaleFactor).clamp(6, 8),
        thumbnailWidth: (120 * scaleFactor).clamp(120, 135),
        thumbnailHeight: (80 * scaleFactor).clamp(80, 90),
        cardPadding: EdgeInsets.symmetric(
          horizontal: (6.0 * scaleFactor).clamp(6.0, 8.0),
          vertical: (4.0 * scaleFactor).clamp(4.0, 6.0),
        ),
        contentSpacing: (14.0 * scaleFactor).clamp(14.0, 16.0),
        titleSubtitleSpacing: (6.0 * scaleFactor).clamp(6.0, 8.0),
        cardVerticalSpacing: (8.0 * scaleFactor).clamp(8.0, 10.0),
      );
    } else if (screenWidth >= 375) {
      // Regular phones (baseline - CPH2487 and similar)
      return DeviceInfo(
        isTablet: false,
        columnWidth: screenWidth * 0.82,
        cardHeight: 88,
        listHeight: 340,
        cardsPerColumn: 3,
        gridColumns: 1,
        cardAspectRatio: 3.0,
        subtitleMaxWidth: 150,
        horizontalPadding: 16.0,
        columnSpacing: 18.0,
        dividerLeftMargin: 152,
        dividerSpacing: 6,
        thumbnailWidth: 120,
        thumbnailHeight: 80,
        cardPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        contentSpacing: 14.0,
        titleSubtitleSpacing: 6.0,
        cardVerticalSpacing: 8.0,
      );
    } else {
      // Small phones
      return DeviceInfo(
        isTablet: false,
        columnWidth: screenWidth * 0.85,
        cardHeight: 82,
        listHeight: 320,
        cardsPerColumn: 3,
        gridColumns: 1,
        cardAspectRatio: 2.8,
        subtitleMaxWidth: 120,
        horizontalPadding: 14.0,
        columnSpacing: 16.0,
        dividerLeftMargin: 140,
        dividerSpacing: 5,
        thumbnailWidth: 110,
        thumbnailHeight: 75,
        cardPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        contentSpacing: 12.0,
        titleSubtitleSpacing: 5.0,
        cardVerticalSpacing: 6.0,
      );
    }
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

  void _handlePlayPause() {
    debugPrint('Play/Pause tapped');
  }
}

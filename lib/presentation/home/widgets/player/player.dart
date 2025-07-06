import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../data/models/conversation.dart';
import '../../../../data/datasources/mock_data_source.dart';
import 'mini_player.dart';

class Player extends StatefulWidget {
  final Widget child;

  const Player({super.key, required this.child});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> with TickerProviderStateMixin {
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

  void _handlePlayPause() {
    debugPrint('Play/Pause tapped');
  }

  @override
  Widget build(BuildContext context) {
    final miniPlayerData = MockDataSource.getMiniPlayerData();

    return AnimatedBuilder(
      animation: _bounceAnimation ?? const AlwaysStoppedAnimation(0.0),
      builder: (context, child) {
        return Stack(
          children: [
            // Main content with adaptive height
            _buildMainContent(miniPlayerData),

            // Mini Player Overlay
            if (miniPlayerData != null)
              MiniPlayer(
                playerData: miniPlayerData,
                onPlayPause: _handlePlayPause,
                bounceProgress: _bounceAnimation?.value ?? 0.0,
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
    );
  }

  Widget _buildMainContent(MiniPlayerData? miniPlayerData) {
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
          widget.child,

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
}

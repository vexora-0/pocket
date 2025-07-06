import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../data/models/conversation.dart';
import '../../../../core/responsive/responsive.dart';
import 'expanded_player.dart';

/// A draggable audio player widget that transitions between minimized and expanded states.
///
/// This widget provides a bottom sheet-style interface that can be dragged to expand
/// from a minimized state (15% screen height) to an expanded state (85% screen height).
/// It includes an animated Pocket SVG that scales and moves during the transition.
class MiniPlayer extends StatefulWidget {
  /// The player data to display. If null, the widget will be hidden.
  final MiniPlayerData? playerData;

  /// Callback fired when the play/pause button is tapped.
  final VoidCallback? onPlayPause;

  /// Callback fired when the menu button is tapped.
  final VoidCallback? onMenuTap;

  /// Callback fired when the player position changes during drag.
  final Function(double)? onPositionChanged;

  /// Progress value for bounce animation effects on the SVG.
  final double bounceProgress;

  const MiniPlayer({
    super.key,
    this.playerData,
    this.onPlayPause,
    this.onMenuTap,
    this.onPositionChanged,
    this.bounceProgress = 0.0,
  });

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  double _playerPosition = 0.15;
  bool _isDragHandlePressed = false;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    if (widget.playerData == null) {
      return const SizedBox.shrink();
    }

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        setState(() {
          _playerPosition = notification.extent;
          _isDragging = notification.minExtent != notification.maxExtent;
        });
        widget.onPositionChanged?.call(notification.extent);
        return false;
      },
      child: NotificationListener<ScrollStartNotification>(
        onNotification: (notification) {
          setState(() {
            _isDragHandlePressed = true;
            _isDragging = true;
          });
          return false;
        },
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (notification) {
            setState(() {
              _isDragHandlePressed = false;
              _isDragging = false;
            });
            return false;
          },
          child: DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 0.85,
            snap: true,
            snapSizes: const [0.15, 0.85],
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        _buildDragHandle(),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.85,
                              child: Stack(
                                children: [
                                  _buildFadingMinimizedContent(),
                                  Positioned.fill(
                                    child: ExpandedPlayer(
                                      playerPosition: _playerPosition,
                                      onPlayPause: widget.onPlayPause,
                                      onMenuTap: widget.onMenuTap,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildAnimatedPocketSVG(),
                    _buildVerticalShadowOverlay(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: double.infinity,
        height: 20,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color:
                  _isDragHandlePressed || _isDragging
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedPocketSVG() {
    /// Calculate SVG animation progress with enhanced sensitivity
    /// Maps player position (0.15-0.85) to animation progress (0.0-1.0)
    /// with 1.3x multiplier for more responsive animation
    final rawProgress = (_playerPosition - 0.15) / (0.85 - 0.15);
    final animationProgress = (rawProgress * 1.3).clamp(0.0, 1.0);

    /// Apply subtle bounce effect to SVG scaling
    /// Creates a dynamic size modifier based on bounce progress
    final bounceEffect = widget.bounceProgress * 0.01;
    final bounceFactor =
        1.0 + (bounceEffect * (1 - (widget.bounceProgress * 2 - 1).abs()));

    final deviceInfo = context.responsive;

    /// Calculate SVG size and position based on animation progress
    /// Base size grows from initial size to 330px larger during expansion
    /// with 0.85 multiplier for refined scaling
    final baseSvgSize =
        deviceInfo.miniPlayerSvgInitialSize +
        (330.0 * animationProgress * 0.85);
    final svgSize = baseSvgSize * bounceFactor;

    /// Calculate horizontal position - SVG moves left as player expands
    /// with 0.9 multiplier for smoother movement
    final leftPosition = 20.0 - (175.0 * animationProgress * 0.9);
    final topPosition = _calculateVerticalCenter(svgSize);

    return Positioned(
      left: leftPosition,
      top: topPosition,
      child: IgnorePointer(
        child: SvgPicture.asset(
          'assets/svgs/pocket.svg',
          width: svgSize,
          height: svgSize,
        ),
      ),
    );
  }

  double _calculateVerticalCenter(double svgSize) {
    final screenHeight = MediaQuery.of(context).size.height;
    final playerHeight = screenHeight * _playerPosition;
    final dragHandleHeight = 20.0;
    final availableHeight = playerHeight - dragHandleHeight;

    /// Centers the SVG vertically within available space with slight upward adjustment
    return dragHandleHeight + (availableHeight - svgSize) / 2 - 8.0;
  }

  Widget _buildFadingMinimizedContent() {
    /// Calculate fade progress for minimized content
    /// Content starts fading when player expands from 15% to 40% of screen height
    /// This creates a smooth transition where minimized content disappears
    /// as the player expands, making room for the expanded interface
    final fadeProgress = ((_playerPosition - 0.15) / (0.4 - 0.15)).clamp(
      0.0,
      1.0,
    );
    final contentOpacity = 1.0 - fadeProgress;

    // Get device info for responsive sizing
    final deviceInfo = context.responsive;

    return Positioned(
      top: 12,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: contentOpacity,
        duration: const Duration(milliseconds: 100), // Quick response to drag
        child: GestureDetector(
          // Make the entire minimized content area draggable
          behavior: HitTestBehavior.translucent,
          child: SizedBox(
            // Make this area draggable by allowing gestures to pass through
            height: deviceInfo.miniPlayerContentHeight, // Use responsive height
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: deviceInfo.miniPlayerTextVerticalPadding,
              ),
              child: Row(
                children: [
                  // Left side - Text and status info (without SVG since it's now animated)
                  Expanded(
                    child: GestureDetector(
                      // Allow drag gestures to pass through
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: deviceInfo.miniPlayerTextLeftPadding,
                        ), // Use responsive left padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sayan's pocket",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceInfo.miniPlayerTitleFontSize,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(height: deviceInfo.miniPlayerTextSpacing),
                            Row(
                              children: [
                                // Connected status
                                Text(
                                  'Connected',
                                  style: TextStyle(
                                    color: Colors.green.shade400,
                                    fontSize:
                                        deviceInfo.miniPlayerStatusFontSize,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                SizedBox(
                                  width: deviceInfo.miniPlayerStatusSpacing,
                                ),
                                // Dot separator
                                Container(
                                  width: 3,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: deviceInfo.miniPlayerStatusSpacing,
                                ),
                                // Battery percentage
                                Text(
                                  '75%',
                                  style: TextStyle(
                                    color: Colors.white.withValues(
                                      alpha: 0.5,
                                    ), // Grayer color as requested
                                    fontSize:
                                        deviceInfo.miniPlayerStatusFontSize,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const SizedBox(width: 4),
                                // Battery icon
                                _buildBatteryIcon(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Right side - Record button
                  GestureDetector(
                    onTap: () {
                      // Handle record button tap
                      debugPrint('Record button tapped');
                    },
                    behavior: HitTestBehavior.deferToChild,
                    child: _buildRecordButton(deviceInfo),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBatteryIcon() {
    return SvgPicture.asset('assets/icons/battery.svg', width: 20, height: 20);
  }

  Widget _buildRecordButton(ResponsiveConfiguration deviceInfo) {
    // Calculate button opacity - fade out as player expands
    final buttonFadeProgress = ((_playerPosition - 0.15) / (0.4 - 0.15)).clamp(
      0.0,
      1.0,
    );
    final buttonOpacity =
        1.0 - buttonFadeProgress; // Fade out as player expands

    return AnimatedOpacity(
      opacity: buttonOpacity,
      duration: const Duration(milliseconds: 100),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceInfo.miniPlayerRecordButtonPadding,
            vertical: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Audio SVG icon
              SvgPicture.asset('assets/icons/audio.svg', width: 16, height: 16),
              const SizedBox(width: 8),
              // Record text
              Text(
                'Record',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: deviceInfo.miniPlayerRecordButtonFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalShadowOverlay() {
    // Calculate shadow opacity based on drag progress
    // Shadow only appears when mini player is fully expanded (85%)
    final shadowProgress = ((_playerPosition - 0.80) / (0.85 - 0.80)).clamp(
      0.0,
      1.0,
    );
    final shadowOpacity = shadowProgress * 1; // Max opacity for shadow

    return Positioned(
      left: 0,
      top: 0,
      bottom: 115, // Increased vertical length (was 120, now 60)
      width: 150, // Keep same width to avoid covering left effects
      child: IgnorePointer(
        // Allow gestures to pass through the shadow
        child: AnimatedOpacity(
          opacity: shadowOpacity,
          duration: const Duration(milliseconds: 100), // Quick response to drag
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withValues(
                    alpha: 0.8,
                  ), // Strong shadow at left edge
                  Colors.black.withValues(alpha: 0.1), // Medium shadow
                  Colors.black.withValues(alpha: 0.0), // Fade to transparent
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

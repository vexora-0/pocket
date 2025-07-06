import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'dart:async';
import 'dart:ui';

/// The expanded view of the audio player with animated waveform visualization.
///
/// This widget displays the full player interface with animated waveform bars,
/// control buttons, and visual effects. It includes a complex animation sequence
/// that triggers when the player is expanded above 50% of screen height.
class ExpandedPlayer extends StatefulWidget {
  /// The current player position as a fraction of screen height (0.0 to 1.0).
  final double playerPosition;

  /// Callback fired when the play/pause button is tapped.
  final VoidCallback? onPlayPause;

  /// Callback fired when the menu button is tapped.
  final VoidCallback? onMenuTap;

  const ExpandedPlayer({
    super.key,
    required this.playerPosition,
    this.onPlayPause,
    this.onMenuTap,
  });

  @override
  State<ExpandedPlayer> createState() => _ExpandedPlayerState();
}

class _ExpandedPlayerState extends State<ExpandedPlayer>
    with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late Animation<double> _mainAnimation;

  bool _hasTriggeredFullAnimation = false;
  List<double> _currentBarHeights = [];
  List<double> _initialBarHeights = [];
  Timer? _continuousAnimationTimer;

  final List<double> _baseWaveformData = [
    0.0,
    0.156,
    0.309,
    0.454,
    0.588,
    0.707,
    0.809,
    0.891,
    0.951,
    0.988,
    1.0,
    0.988,
    0.951,
    0.891,
    0.809,
    0.707,
    0.588,
    0.454,
    0.309,
    0.156,
    0.0,
    0.156,
    0.309,
    0.454,
    0.588,
    0.707,
    0.809,
    0.891,
    0.951,
    0.988,
    1.0,
    0.988,
    0.951,
    0.891,
    0.809,
    0.707,
    0.588,
    0.454,
    0.309,
    0.156,
  ];

  @override
  void initState() {
    super.initState();

    _mainAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _mainAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainAnimationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _initializeBarHeights();
    _mainAnimationController.addListener(_updateBarHeights);
  }

  void _initializeBarHeights() {
    _initialBarHeights =
        _baseWaveformData.map((amplitude) {
          if (math.Random().nextDouble() < 0.4) {
            return 0.05;
          }
          return amplitude * 0.3;
        }).toList();

    _currentBarHeights = List.from(_initialBarHeights);
  }

  void _updateBarHeights() {
    if (!mounted) return;

    setState(() {
      final progress = _mainAnimation.value;

      for (int i = 0; i < _currentBarHeights.length; i++) {
        final random = math.Random(i);

        if (progress < 0.7) {
          final expansionProgress = (progress / 0.7).clamp(0.0, 1.0);
          final targetHeight = 0.15 + (random.nextDouble() * 0.35);
          _currentBarHeights[i] =
              _initialBarHeights[i] +
              (targetHeight - _initialBarHeights[i]) *
                  Curves.easeInOut.transform(expansionProgress);
        } else if (progress < 0.9) {
          final fluctuationProgress = ((progress - 0.7) / 0.2).clamp(0.0, 1.0);
          final baseHeight = 0.25 + (random.nextDouble() * 0.25);
          final fluctuation =
              math.sin(fluctuationProgress * math.pi * 2 + i) * 0.06;
          _currentBarHeights[i] = (baseHeight + fluctuation).clamp(0.05, 0.6);
        } else {
          final settleProgress = ((progress - 0.9) / 0.1).clamp(0.0, 1.0);
          final targetHeight = 0.3 + (random.nextDouble() * 0.15);
          final currentHeight = _currentBarHeights[i];
          _currentBarHeights[i] =
              currentHeight +
              (targetHeight - currentHeight) *
                  Curves.easeInOut.transform(settleProgress);
        }
      }
    });
  }

  @override
  void didUpdateWidget(ExpandedPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.playerPosition > 0.5 && !_hasTriggeredFullAnimation) {
      _hasTriggeredFullAnimation = true;
      _startAnimationSequence();
    }

    if (widget.playerPosition < 0.4 && _hasTriggeredFullAnimation) {
      _resetAnimation();
    }
  }

  void _startAnimationSequence() async {
    await _mainAnimationController.forward();

    _startContinuousAnimation();

    await Future.delayed(const Duration(milliseconds: 1000));
    _fadeToLowHeightsAnimation();
  }

  void _startContinuousAnimation() {
    if (!mounted) return;

    _continuousAnimationTimer?.cancel();
    _continuousAnimationTimer = Timer.periodic(
      const Duration(milliseconds: 150),
      (timer) {
        if (!mounted || widget.playerPosition < 0.5) {
          timer.cancel();
          return;
        }

        setState(() {
          final random = math.Random();
          for (int i = 0; i < _currentBarHeights.length; i++) {
            if (random.nextDouble() < 0.2) {
              final currentHeight = _currentBarHeights[i];
              final variation = (random.nextDouble() - 0.5) * 0.15;
              _currentBarHeights[i] = (currentHeight + variation).clamp(
                0.05,
                0.8,
              );
            }
          }
        });
      },
    );
  }

  void _fadeToLowHeightsAnimation() {
    if (!mounted) return;

    final targetHeights =
        _currentBarHeights.map((height) {
          final random = math.Random();
          return 0.1 + (random.nextDouble() * 0.2);
        }).toList();
    final fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.easeInCubic),
    );

    fadeAnimation.addListener(() {
      if (!mounted) return;
      setState(() {
        for (int i = 0; i < _currentBarHeights.length; i++) {
          final currentHeight = _currentBarHeights[i];
          final targetHeight = targetHeights[i];
          _currentBarHeights[i] =
              currentHeight +
              (targetHeight - currentHeight) * fadeAnimation.value;
        }
      });
    });

    fadeController.forward().then((_) {
      fadeController.dispose();
      _continuousAnimationTimer?.cancel();
    });
  }

  void _resetAnimation() {
    _hasTriggeredFullAnimation = false;
    _mainAnimationController.reset();
    _continuousAnimationTimer?.cancel();
    _initializeBarHeights();
  }

  @override
  void dispose() {
    _mainAnimationController.dispose();
    _continuousAnimationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Purple and Blue ellipses (bottom layer) - only when expanded
        if (widget.playerPosition > 0.75) _buildBottomEllipses(),
        // 2. Brown ellipse (middle layer) - only when expanded
        if (widget.playerPosition > 0.75) _buildMiddleEllipse(),
        // 3. Blur overlay (only affects bottom area where ellipses are) - only when expanded
        if (widget.playerPosition > 0.75) _buildBottomBlurOverlay(),
        // 4. Expanded content with buttons (top layer)
        _buildFadingExpandedContent(),
        // 5. Centered waveform overlay (very top)
        _buildPositionedWaveform(),
      ],
    );
  }

  Widget _buildBottomEllipses() {
    return Positioned.fill(
      child: Stack(
        children: [
          // Purple ellipse - bottom right corner
          Positioned(
            bottom: 0,
            right: -80,
            child: SvgPicture.asset(
              'assets/svgs/purpleElipse.svg',
              width: 300,
              height: 300,
            ),
          ),
          // Blue ellipse - bottom left corner
          Positioned(
            bottom: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/svgs/blueElipse.svg',
              width: 400,
              height: 300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleEllipse() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: -40,
      child: Center(
        child: SvgPicture.asset(
          'assets/svgs/brownElipse.svg',
          width: 350,
          height: 250,
        ),
      ),
    );
  }

  Widget _buildBottomBlurOverlay() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 250, // Only cover the bottom area where ellipses are positioned
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _buildFadingExpandedContent() {
    // Calculate fade opacity based on drag progress
    final fadeProgress = ((widget.playerPosition - 0.3) / (0.7 - 0.3)).clamp(
      0.0,
      1.0,
    );
    final contentOpacity = fadeProgress;

    return Positioned.fill(
      child: AnimatedOpacity(
        opacity: contentOpacity,
        duration: const Duration(milliseconds: 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // New Memory heading and timer
              Text(
                'New memory',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 12),
              // Timer
              Text(
                '00:08:55',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),

              // Spacer for waveform area
              const Spacer(),

              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSvgControlButton(
                    'assets/icons/options.svg',
                    widget.onMenuTap ?? () {},
                  ),
                  const SizedBox(width: 20),
                  _buildSvgControlButton(
                    'assets/icons/pause.svg',
                    widget.onPlayPause ?? () {},
                  ),
                  const SizedBox(width: 20),
                  _buildSvgControlButton('assets/icons/stop.svg', () {}),
                ],
              ),

              const SizedBox(height: 20),
              // Connected status and battery at bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Connected',
                    style: TextStyle(
                      color: Colors.green.shade400,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '75%',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/icons/battery.svg',
                    width: 20,
                    height: 20,
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPositionedWaveform() {
    /// Calculate waveform fade opacity based on player expansion
    /// The waveform starts fading in when the player reaches 50% height
    /// and reaches full opacity at 85% height for smooth visual transition
    final waveformFadeProgress = ((widget.playerPosition - 0.5) / (0.85 - 0.5))
        .clamp(0.0, 1.0);
    final waveformOpacity = Curves.easeInOut.transform(waveformFadeProgress);

    const waveformHeight = 130.0;
    final topPosition = _calculateWaveformVerticalCenter(waveformHeight);

    return Positioned(
      left: 24,
      right: 24,
      top: topPosition,
      height: waveformHeight,
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: waveformOpacity,
          duration: const Duration(milliseconds: 200),
          child: Center(child: _buildAnimatedWaveform()),
        ),
      ),
    );
  }

  double _calculateWaveformVerticalCenter(double waveformHeight) {
    final screenHeight = MediaQuery.of(context).size.height;
    final playerHeight = screenHeight * widget.playerPosition;
    final dragHandleHeight = 20.0;
    final availableHeight = playerHeight - dragHandleHeight;

    // Center the waveform vertically within the available space
    return dragHandleHeight + (availableHeight - waveformHeight) / 2 - 15;
  }

  Widget _buildAnimatedWaveform() {
    /// Calculate waveform bar opacity based on player expansion level
    /// This creates a tiered transparency system for better visual hierarchy:
    /// - Fully expanded (85%+): Maximum opacity (0.9)
    /// - Mostly expanded (75-85%): Medium-high opacity (0.5-0.9)
    /// - Partially expanded (50-75%): Medium opacity (0.25-0.5)
    /// - Minimally expanded (30-50%): Low opacity (0.15-0.25)
    double alpha;
    if (widget.playerPosition >= 0.85) {
      alpha = 0.9;
    } else if (widget.playerPosition >= 0.75) {
      final progress = (widget.playerPosition - 0.75) / (0.85 - 0.75);
      alpha = 0.5 + (0.4 * progress);
    } else if (widget.playerPosition >= 0.5) {
      final progress = (widget.playerPosition - 0.5) / (0.75 - 0.5);
      alpha = 0.25 + (0.25 * progress);
    } else {
      final progress = ((widget.playerPosition - 0.3) / (0.5 - 0.3)).clamp(
        0.0,
        1.0,
      );
      alpha = 0.15 + (0.1 * progress);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        /// Calculate responsive bar layout based on available screen width
        /// Each bar is 6px wide with 6px spacing (3px margin on each side)
        /// This ensures the waveform adapts to different screen sizes
        /// by showing only the bars that can fit within the available space
        const barWidth = 6.0;
        const barSpacing = 6.0;
        final availableWidth = constraints.maxWidth;
        final maxBars = (availableWidth / (barWidth + barSpacing)).floor();

        final visibleBarHeights = _currentBarHeights.take(maxBars).toList();

        return SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                visibleBarHeights.map((amplitude) {
                  final barHeight = (amplitude * 75).clamp(1.0, 75.0);

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 6,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: alpha),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildSvgControlButton(String svgAsset, VoidCallback onTap) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(23),
          onTap: onTap,
          child: Center(
            child: SvgPicture.asset(
              svgAsset,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

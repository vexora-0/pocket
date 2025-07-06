import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'dart:async';

class ExpandedPlayer extends StatefulWidget {
  final double playerPosition;
  final VoidCallback? onPlayPause;
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

  // Static waveform data
  final List<double> _baseWaveformData = [
  0.2, 0.5, 0.15, 0.45, 0.2, 0.55, 0.2, 0.15, // Left tapering
  0.7, 0.8, 0.75, 0.9, 0.85, 0.8, 0.9, 0.8,   // First group of tall bars
  0.15, 0.2, 0.15, 0.2, 0.15, 0.15, 0.2, 0.15, // Center dotted segment
  0.8, 0.9, 0.85, 0.8, 0.9, 0.8, 0.75, 0.7,   // Second group of tall bars
  0.2, 0.55, 0.2, 0.45, 0.15, 0.5, 0.2, 0.15, // Right tapering
];


  @override
  void initState() {
    super.initState();

    _mainAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000), // Single 2 second animation
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
          // 40% of bars should be dots (very low height)
          if (math.Random().nextDouble() < 0.4) {
            return 0.05; // Very low height (dots)
          }
          return amplitude * 0.3; // Other bars are also quite low initially
        }).toList();

    _currentBarHeights = List.from(_initialBarHeights);
  }

  void _updateBarHeights() {
    if (!mounted) return;

    setState(() {
      final progress = _mainAnimation.value;

      for (int i = 0; i < _currentBarHeights.length; i++) {
        // Create smooth wave-like animation with different phases
        final random = math.Random(i); // Use index as seed for consistency

        if (progress < 0.7) {
          // Phase 1: Gentle expansion from dots/low to moderate heights (0-70% of animation)
          final expansionProgress = (progress / 0.7).clamp(0.0, 1.0);
          final targetHeight =
              0.15 +
              (random.nextDouble() *
                  0.35); // 0.15 to 0.5 range (more conservative)
          _currentBarHeights[i] =
              _initialBarHeights[i] +
              (targetHeight - _initialBarHeights[i]) *
                  Curves.easeInOut.transform(expansionProgress);
        } else if (progress < 0.9) {
          // Phase 2: Subtle fluctuations (70-90% of animation)
          final fluctuationProgress = ((progress - 0.7) / 0.2).clamp(0.0, 1.0);
          final baseHeight =
              0.25 +
              (random.nextDouble() *
                  0.25); // 0.25 to 0.5 range (more controlled)
          final fluctuation =
              math.sin(fluctuationProgress * math.pi * 2 + i) *
              0.06; // Reduced intensity
          _currentBarHeights[i] = (baseHeight + fluctuation).clamp(0.05, 0.6);
        } else {
          // Phase 3: Gentle settle to similar heights (90-100% of animation)
          final settleProgress = ((progress - 0.9) / 0.1).clamp(0.0, 1.0);
          final targetHeight =
              0.3 +
              (random.nextDouble() * 0.15); // 0.3 to 0.45 range (more similar)
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

    // Start wave animation when height > 0.5
    if (widget.playerPosition > 0.5 && !_hasTriggeredFullAnimation) {
      _hasTriggeredFullAnimation = true;
      _startAnimationSequence();
    }

    // Reset when minimized
    if (widget.playerPosition < 0.4 && _hasTriggeredFullAnimation) {
      _resetAnimation();
    }
  }

  void _startAnimationSequence() async {
    // Start the main 2 second animation
    await _mainAnimationController.forward();

    // After main animation, start continuous subtle animation for 1 second
    _startContinuousAnimation();

    // After 1 second of continuous animation, fade to low heights
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
              // 20% chance to change (less frequent)
              // Subtle random changes around current height
              final currentHeight = _currentBarHeights[i];
              final variation =
                  (random.nextDouble() - 0.5) * 0.15; // ±7.5% variation
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

    // Generate random target heights between 0.1 and 0.3 for each bar
    final targetHeights =
        _currentBarHeights.map((height) {
          final random = math.Random();
          return 0.1 + (random.nextDouble() * 0.2); // 0.1 to 0.3 range
        }).toList();

    // Smooth animation to fade all bars to low random heights over 1 second
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
        // Expanded content with fade in
        _buildFadingExpandedContent(),
        // Centered waveform overlay
        _buildPositionedWaveform(),
      ],
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
        child: Container(
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
    // Calculate fade opacity for waveform with smooth curve - starts fading in when player height > 0.5
    final waveformFadeProgress = ((widget.playerPosition - 0.5) / (0.85 - 0.5))
        .clamp(0.0, 1.0);
    // Apply easing curve for smoother transition
    final waveformOpacity = Curves.easeInOut.transform(waveformFadeProgress);

    // Calculate waveform position using same logic as Pocket SVG
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
    // Calculate alpha with smooth transition based on expansion state
    double alpha;
    if (widget.playerPosition >= 0.85) {
      alpha = 0.9;
    } else if (widget.playerPosition >= 0.75) {
      // Smooth transition from 0.5 to 0.9 between 0.75 and 0.85
      final progress = (widget.playerPosition - 0.75) / (0.85 - 0.75);
      alpha = 0.5 + (0.4 * progress);
    } else if (widget.playerPosition >= 0.5) {
      // Smooth transition from 0.25 to 0.5 between 0.5 and 0.75
      final progress = (widget.playerPosition - 0.5) / (0.75 - 0.5);
      alpha = 0.25 + (0.25 * progress);
    } else {
      // Smooth transition from 0.15 to 0.25 between 0.3 and 0.5
      final progress = ((widget.playerPosition - 0.3) / (0.5 - 0.3)).clamp(
        0.0,
        1.0,
      );
      alpha = 0.15 + (0.1 * progress);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate how many bars can fit in the available width
        const barWidth = 6.0;
        const barSpacing = 6.0; // 3px margin on each side
        final availableWidth = constraints.maxWidth;
        final maxBars = (availableWidth / (barWidth + barSpacing)).floor();

        // Use only the bars that can fit
        final visibleBarHeights = _currentBarHeights.take(maxBars).toList();

        return Container(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                visibleBarHeights.asMap().entries.map((entry) {
                  final index = entry.key;
                  final amplitude = entry.value;
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

  Widget _buildControlButton(IconData icon, VoidCallback onTap) {
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
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 24),
        onPressed: onTap,
      ),
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

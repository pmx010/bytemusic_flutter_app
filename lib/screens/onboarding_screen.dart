import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    
    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
    
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    
    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    _fadeController.reset();
    _fadeController.forward();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      widget.onComplete();
    }
  }

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to Bytemusic',
      subtitle: 'Your free daily music experience starts here',
      illustration: const _OnboardingIllustration1(),
      colors: const [Color(0xFF4338CA), Color(0xFF22C55E)],
    ),
    OnboardingPage(
      title: 'Stream Unlimited',
      subtitle: 'Access millions of songs, create playlists, and discover new favorites',
      illustration: const _OnboardingIllustration2(),
      colors: const [Color(0xFF22C55E), Color(0xFF4338CA)],
    ),
    OnboardingPage(
      title: 'Free Daily Music',
      subtitle: 'Get fresh curated playlists every day - completely free, no subscription needed',
      illustration: const _OnboardingIllustration3(),
      colors: const [Color(0xFF1E1B4B), Color(0xFF4338CA)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildSkipButton(),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: AnimatedBuilder(
                  animation: _floatAnimation,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _floatAnimation.value),
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: _pages.length,
                      itemBuilder: (context, index) => _pages[index],
                    ),
                  ),
                ),
              ),
            ),
            _buildIndicator(),
            const SizedBox(height: 24),
            _buildNavigationButtons(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextButton(
          onPressed: widget.onComplete,
          child: Text(
            'Skip',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentPage == index ? AppColors.accent : AppColors.borderSubtle,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          if (_currentPage > 0)
            TextButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                );
              },
              child: Text(
                'Back',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
            const SizedBox(width: 80),
          const Spacer(),
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32),
              ),
              child: Text(
                _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget illustration;
  final List<Color> colors;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.illustration,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.7,
            height: size.width * 0.7,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: colors[0].withOpacity(0.3),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: illustration,
            ),
          ),
          const SizedBox(height: 48),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Righteous',
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Page 1: Welcome illustration - Music note with play
class _OnboardingIllustration1 extends StatelessWidget {
  const _OnboardingIllustration1();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 40,
          left: 30,
          child: _buildNote(0, -0.3),
        ),
        Positioned(
          top: 60,
          right: 40,
          child: _buildNote(0.2, 0),
        ),
        Positioned(
          bottom: 80,
          left: 50,
          child: _buildNote(-0.1, 0.2),
        ),
        // Central play button
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.music_note_rounded,
            size: 60,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNote(double rotation, double offset) {
    return Transform.rotate(
      angle: rotation,
      child: Transform.translate(
        offset: Offset(offset * 20, 0),
        child: Icon(
          Icons.music_note_rounded,
          size: 40,
          color: AppColors.white.withOpacity(0.6),
        ),
      ),
    );
  }
}

// Page 2: Streaming illustration - Waveform with headphones
class _OnboardingIllustration2 extends StatelessWidget {
  const _OnboardingIllustration2();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Headphones
        const Icon(
          Icons.headphones_rounded,
          size: 80,
          color: AppColors.white,
        ),
        // Sound waves
        Positioned(
          left: 20,
          child: _buildWave(40),
        ),
        Positioned(
          right: 20,
          child: _buildWave(40),
        ),
        Positioned(
          left: 40,
          child: _buildWave(24),
        ),
        Positioned(
          right: 40,
          child: _buildWave(24),
        ),
      ],
    );
  }

  Widget _buildWave(double size) {
    return Icon(
      Icons.graphic_eq_rounded,
      size: size,
      color: AppColors.white.withOpacity(0.7),
    );
  }
}

// Page 3: Free daily music - Calendar with star
class _OnboardingIllustration3 extends StatelessWidget {
  const _OnboardingIllustration3();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Calendar icon
        Container(
          width: 160,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                size: 50,
                color: AppColors.white,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'FREE',
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 18,
                    color: AppColors.accent,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Star decoration
        Positioned(
          top: 30,
          right: 40,
          child: Icon(
            Icons.star_rounded,
            size: 36,
            color: AppColors.accent.withOpacity(0.8),
          ),
        ),
        // Music notes floating
        const Positioned(
          top: 60,
          left: 40,
          child: Icon(
            Icons.music_note_rounded,
            size: 28,
            color: AppColors.white,
          ),
        ),
        const Positioned(
          bottom: 60,
          right: 50,
          child: Icon(
            Icons.queue_music_rounded,
            size: 28,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PermissionScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const PermissionScreen({super.key, required this.onComplete});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  bool _locationGranted = false;
  bool _notificationsGranted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLocation() {
    setState(() => _locationGranted = !_locationGranted);
  }

  void _toggleNotifications() {
    setState(() => _notificationsGranted = !_notificationsGranted);
  }

  void _continue() {
    // In a real app, you would request actual permissions here
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),
                  _buildHeader(),
                  const SizedBox(height: 48),
                  _buildPermissionCards(),
                  const Spacer(),
                  _buildContinueButton(),
                  const SizedBox(height: 16),
                  _buildSkipButton(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4338CA), Color(0xFF22C55E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4338CA).withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_active_rounded,
            size: 50,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Customize Your Experience',
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: 26,
            color: AppColors.white,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Enable permissions to get the most out of Bytemusic',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPermissionCards() {
    return Column(
      children: [
        _buildPermissionCard(
          icon: Icons.location_on_rounded,
          title: 'Location Services',
          description: 'Discover local concerts and music events near you',
          isEnabled: _locationGranted,
          onTap: _toggleLocation,
          gradient: const [Color(0xFF4338CA), Color(0xFF6366F1)],
        ),
        const SizedBox(height: 16),
        _buildPermissionCard(
          icon: Icons.notifications_rounded,
          title: 'Push Notifications',
          description: 'Get notified about new releases and trending songs',
          isEnabled: _notificationsGranted,
          onTap: _toggleNotifications,
          gradient: const [Color(0xFF22C55E), Color(0xFF16A34A)],
        ),
      ],
    );
  }

  Widget _buildPermissionCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isEnabled,
    required VoidCallback onTap,
    required List<Color> gradient,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isEnabled 
              ? gradient[0].withOpacity(0.15)
              : AppColors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isEnabled ? gradient[0] : AppColors.borderSubtle,
            width: isEnabled ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isEnabled 
                      ? gradient 
                      : [AppColors.textTertiary, AppColors.textTertiary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: AppColors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isEnabled ? gradient[0] : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isEnabled ? gradient[0] : AppColors.textTertiary,
                    width: 2,
                  ),
                ),
                child: isEnabled
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.white,
                        size: 20,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    final hasPermissions = _locationGranted || _notificationsGranted;
    
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: hasPermissions
            ? const LinearGradient(
                colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
              )
            : null,
        color: hasPermissions ? null : AppColors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        boxShadow: hasPermissions
            ? [
                BoxShadow(
                  color: const Color(0xFF22C55E).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: _continue,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          hasPermissions ? 'Continue' : 'Skip for Now',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: hasPermissions ? AppColors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return TextButton(
      onPressed: _continue,
      child: Text(
        'Maybe Later',
        style: TextStyle(
          fontSize: 15,
          color: AppColors.textTertiary,
        ),
      ),
    );
  }
}

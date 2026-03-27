import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildAccountSection()),
            SliverToBoxAdapter(child: _buildPlaybackSection()),
            SliverToBoxAdapter(child: _buildAppSection()),
            SliverToBoxAdapter(child: _buildSupportSection()),
            SliverToBoxAdapter(child: _buildSignOut()),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: AppColors.white,
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          const Text('Settings', style: AppTextStyles.heading),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return _SettingsSection(
      title: 'Account',
      children: [
        _SettingsTile(
          icon: Icons.person_outline_rounded,
          title: 'Edit Profile',
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.lock_outline_rounded,
          title: 'Change Password',
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.credit_card_rounded,
          title: 'Subscription',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Pro',
              style: TextStyle(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        _SettingsTile(
          icon: Icons.security_rounded,
          title: 'Privacy',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildPlaybackSection() {
    return _SettingsSection(
      title: 'Playback',
      children: [
        _SettingsTile(
          icon: Icons.equalizer_rounded,
          title: 'Equalizer',
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.volume_up_rounded,
          title: 'Volume Normalization',
          trailing: Switch(
            value: true,
            onChanged: (_) {},
            activeColor: AppColors.accent,
          ),
        ),
        _SettingsTile(
          icon: Icons.speed_rounded,
          title: 'Crossfade',
          trailing: Text('Off', style: TextStyle(color: AppColors.textSecondary)),
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.headphones_rounded,
          title: 'Audio Quality',
          trailing: Text('High', style: TextStyle(color: AppColors.textSecondary)),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildAppSection() {
    return _SettingsSection(
      title: 'App',
      children: [
        _SettingsTile(
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          trailing: Switch(
            value: true,
            onChanged: (_) {},
            activeColor: AppColors.accent,
          ),
        ),
        _SettingsTile(
          icon: Icons.palette_outlined,
          title: 'Appearance',
          trailing: Text('Dark', style: TextStyle(color: AppColors.textSecondary)),
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.language_rounded,
          title: 'Language',
          trailing: Text('English', style: TextStyle(color: AppColors.textSecondary)),
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.storage_rounded,
          title: 'Storage',
          subtitle: '1.2 GB used',
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.update_rounded,
          title: 'Check for Updates',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return _SettingsSection(
      title: 'Support',
      children: [
        _SettingsTile(
          icon: Icons.help_outline_rounded,
          title: 'Help Center',
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.feedback_outlined,
          title: 'Send Feedback',
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.info_outline_rounded,
          title: 'About',
          subtitle: 'Version 1.0.0',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSignOut() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
        ),
        child: ListTile(
          leading: const Icon(Icons.logout_rounded, color: AppColors.accent),
          title: const Text('Sign Out', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600)),
          onTap: () {},
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderSubtle),
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.white.withOpacity(0.8), size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, color: AppColors.white),
        ),
        subtitle: subtitle != null
            ? Text(subtitle!, style: TextStyle(fontSize: 13, color: AppColors.textSecondary))
            : null,
        trailing: trailing ?? Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}

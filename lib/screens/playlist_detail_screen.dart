import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final String playlistName;
  final String subtitle;
  final Color accentColor;

  const PlaylistDetailScreen({
    super.key,
    this.playlistName = 'Chill Vibes',
    this.subtitle = '32 songs • 1h 45min',
    this.accentColor = const Color(0xFF667EEA),
  });

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(child: _buildInfoSection()),
          SliverToBoxAdapter(child: _buildActions()),
          SliverToBoxAdapter(child: _buildTrackList()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.accentColor,
            widget.accentColor.withOpacity(0.4),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: 60,
            right: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withOpacity(0.08),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.white.withOpacity(0.1),
                                  AppColors.white.withOpacity(0.05),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Icon(
                            Icons.music_note_rounded,
                            color: AppColors.white.withOpacity(0.8),
                            size: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    widget.playlistName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _InfoChip(
            icon: Icons.people_outline_rounded,
            label: '12.5K',
          ),
          const SizedBox(width: 12),
          _InfoChip(
            icon: Icons.favorite_outline_rounded,
            label: '45.2K',
          ),
          const SizedBox(width: 12),
          _InfoChip(
            icon: Icons.share_outlined,
            label: 'Share',
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.accentColor,
                    widget.accentColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: widget.accentColor.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow_rounded, color: AppColors.white, size: 28),
                      SizedBox(width: 8),
                      Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          _ActionButton(
            icon: Icons.shuffle_rounded,
            onTap: () {},
          ),
          const SizedBox(width: 12),
          _ActionButton(
            icon: Icons.favorite_border_rounded,
            onTap: () {},
          ),
          const SizedBox(width: 12),
          _ActionButton(
            icon: Icons.more_vert_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTrackList() {
    final tracks = [
      {'title': 'Midnight Dreams', 'artist': 'Luna Ray', 'duration': '3:42', 'cover': const Color(0xFF667EEA)},
      {'title': 'Electric Heart', 'artist': 'Neon Pulse', 'duration': '4:15', 'cover': const Color(0xFFF093FB)},
      {'title': 'Summer Haze', 'artist': 'Coastal', 'duration': '3:28', 'cover': const Color(0xFF4FACFE)},
      {'title': 'Starlight', 'artist': 'Celestial', 'duration': '3:56', 'cover': const Color(0xFF43E97B)},
      {'title': 'Ocean Waves', 'artist': 'Deep Blue', 'duration': '4:02', 'cover': const Color(0xFF667EEA)},
      {'title': 'City Lights', 'artist': 'Urban Echo', 'duration': '3:18', 'cover': const Color(0xFFF093FB)},
      {'title': 'Moonlight', 'artist': 'Luna Ray', 'duration': '3:45', 'cover': const Color(0xFF4FACFE)},
      {'title': 'Golden Hour', 'artist': 'Sunset', 'duration': '4:30', 'cover': const Color(0xFF43E97B)},
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Section header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.borderSubtle),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 40),
                Expanded(
                  child: Text(
                    'TITLE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textTertiary,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Text(
                  'ALBUM',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textTertiary,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 24),
                Icon(Icons.access_time, size: 16, color: AppColors.textTertiary),
              ],
            ),
          ),
          // Track rows
          ...tracks.asMap().entries.map((entry) {
            final index = entry.key;
            final track = entry.value;
            return _TrackTile(
              index: index + 1,
              title: track['title'] as String,
              artist: track['artist'] as String,
              duration: track['duration'] as String,
              coverColor: track['cover'] as Color,
              isPlaying: index == 0,
              onTap: () {},
            );
          }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.white.withOpacity(0.8)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.08),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white.withOpacity(0.15)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(26),
          onTap: onTap,
          child: Icon(icon, color: AppColors.white, size: 24),
        ),
      ),
    );
  }
}

class _TrackTile extends StatelessWidget {
  final int index;
  final String title;
  final String artist;
  final String duration;
  final Color coverColor;
  final bool isPlaying;
  final VoidCallback onTap;

  const _TrackTile({
    required this.index,
    required this.title,
    required this.artist,
    required this.duration,
    required this.coverColor,
    this.isPlaying = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.borderSubtle),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: isPlaying
                    ? const Icon(Icons.equalizer_rounded, color: AppColors.accent, size: 22)
                    : Text(
                        '$index',
                        style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                      ),
              ),
              const SizedBox(width: 12),
              // Album art
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: coverColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: coverColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.music_note_rounded,
                  color: AppColors.white.withOpacity(0.9),
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isPlaying ? FontWeight.w600 : FontWeight.w500,
                        color: isPlaying ? AppColors.accent : AppColors.white,
                        letterSpacing: 0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      artist,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Chill Vibes',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                duration,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

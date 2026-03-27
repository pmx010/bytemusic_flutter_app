import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildStats()),
            SliverToBoxAdapter(child: _buildSectionTitle('Recently Played')),
            SliverToBoxAdapter(child: _buildRecentList()),
            SliverToBoxAdapter(child: _buildSectionTitle('Top Artists this Month')),
            SliverToBoxAdapter(child: _buildTopArtists()),
            SliverToBoxAdapter(child: _buildSectionTitle('Your Playlists')),
            SliverToBoxAdapter(child: _buildPlaylists()),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
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
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: const Icon(Icons.person_rounded, color: AppColors.white, size: 40),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Demo User', style: AppTextStyles.title),
                const SizedBox(height: 4),
                Text('Premium Member', style: AppTextStyles.captionSecondary),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Pro',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.white),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _StatItem(count: '1,234', label: 'Songs'),
          _StatItem(count: '89', label: 'Playlists'),
          _StatItem(count: '56', label: 'Following'),
          _StatItem(count: '12h', label: 'Listened'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.title),
          Icon(Icons.arrow_forward_rounded, color: AppColors.textTertiary, size: 20),
        ],
      ),
    );
  }

  Widget _buildRecentList() {
    final songs = [
      {'title': 'Midnight Dreams', 'artist': 'Luna Ray', 'time': '2h ago'},
      {'title': 'Electric Heart', 'artist': 'Neon Pulse', 'time': '5h ago'},
      {'title': 'Summer Haze', 'artist': 'Coastal', 'time': '1d ago'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: songs.map((s) => _RecentItem(title: s['title']!, artist: s['artist']!, time: s['time']!)).toList(),
      ),
    );
  }

  Widget _buildTopArtists() {
    final artists = [
      {'name': 'Luna Ray', 'color': const Color(0xFF667EEA)},
      {'name': 'Neon Pulse', 'color': const Color(0xFFF093FB)},
      {'name': 'Coastal', 'color': const Color(0xFF4FACFE)},
    ];
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: artists.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final artist = artists[index];
          return _ArtistCircle(name: artist['name'] as String, color: artist['color'] as Color);
        },
      ),
    );
  }

  Widget _buildPlaylists() {
    final playlists = [
      {'title': 'My Favorites', 'count': '45 songs'},
      {'title': 'Chill Vibes', 'count': '32 songs'},
      {'title': 'Workout Mix', 'count': '28 songs'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: playlists.map((p) => _PlaylistRow(title: p['title']!, count: p['count']!)).toList(),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;
  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Column(
          children: [
            Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white)),
            const SizedBox(height: 4),
            Text(label, style: AppTextStyles.captionSecondary),
          ],
        ),
      ),
    );
  }
}

class _RecentItem extends StatelessWidget {
  final String title;
  final String artist;
  final String time;
  const _RecentItem({required this.title, required this.artist, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.music_note_rounded, color: AppColors.accent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                Text(artist, style: AppTextStyles.captionSecondary),
              ],
            ),
          ),
          Text(time, style: AppTextStyles.captionSecondary),
        ],
      ),
    );
  }
}

class _ArtistCircle extends StatelessWidget {
  final String name;
  final Color color;
  const _ArtistCircle({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person_rounded, color: AppColors.white, size: 36),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontSize: 13, color: AppColors.white)),
      ],
    );
  }
}

class _PlaylistRow extends StatelessWidget {
  final String title;
  final String count;
  const _PlaylistRow({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.playlist_play_rounded, color: AppColors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                Text(count, style: AppTextStyles.captionSecondary),
              ],
            ),
          ),
          Icon(Icons.more_vert, color: AppColors.textTertiary, size: 20),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AlbumDetailScreen extends StatelessWidget {
  final String albumName;
  final String artistName;
  final String year;
  final int trackCount;
  final Color accentColor;

  const AlbumDetailScreen({
    super.key,
    this.albumName = 'Dreamscape',
    this.artistName = 'Luna Ray',
    this.year = '2024',
    this.trackCount = 12,
    this.accentColor = const Color(0xFFF093FB),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(child: _buildAlbumInfo()),
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
          colors: [accentColor, accentColor.withOpacity(0.5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                color: AppColors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.more_vert_rounded),
                color: AppColors.white,
                onPressed: () {},
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.album_rounded, color: AppColors.white, size: 80),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumInfo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            albumName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accentColor, accentColor.withOpacity(0.7)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded, color: AppColors.white, size: 18),
              ),
              const SizedBox(width: 8),
              Text(
                artistName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.white.withOpacity(0.2)),
                ),
                child: Text(
                  year,
                  style: const TextStyle(fontSize: 13, color: AppColors.white),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$trackCount songs',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 12),
              Text(
                '•',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(width: 12),
              Text(
                '48 min',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
            ],
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
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor, accentColor.withOpacity(0.7)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: accentColor.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.play_arrow_rounded, color: AppColors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Icon(Icons.shuffle_rounded, color: AppColors.textSecondary, size: 28),
          const Spacer(),
          Icon(Icons.favorite_border_rounded, color: AppColors.textSecondary, size: 28),
          const SizedBox(width: 20),
          Icon(Icons.more_vert_rounded, color: AppColors.textSecondary, size: 28),
        ],
      ),
    );
  }

  Widget _buildTrackList() {
    final tracks = [
      {'title': 'Dreamscape Intro', 'duration': '1:45'},
      {'title': 'Midnight Dreams', 'duration': '3:42'},
      {'title': 'Starlight', 'duration': '3:56'},
      {'title': 'Moonlight Serenade', 'duration': '4:12'},
      {'title': 'Electric Heart', 'duration': '4:15'},
      {'title': 'Ocean Waves', 'duration': '4:02'},
      {'title': 'City Nights', 'duration': '3:28'},
      {'title': 'Sunset Boulevard', 'duration': '3:45'},
      {'title': 'Neon Lights', 'duration': '3:18'},
      {'title': 'Crystal Sky', 'duration': '4:30'},
      {'title': 'Echoes', 'duration': '3:55'},
      {'title': 'Dreamscape Outro', 'duration': '2:10'},
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: tracks.asMap().entries.map((entry) {
          final index = entry.key;
          final track = entry.value;
          return _AlbumTrackRow(
            index: index + 1,
            title: track['title']!,
            duration: track['duration']!,
          );
        }).toList(),
      ),
    );
  }
}

class _AlbumTrackRow extends StatelessWidget {
  final int index;
  final String title;
  final String duration;

  const _AlbumTrackRow({
    required this.index,
    required this.title,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderSubtle),
        ),
      ),
      child: Row(
        children: [
          Text(
            '$index',
            style: TextStyle(fontSize: 14, color: AppColors.textTertiary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
          ),
          Text(
            duration,
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

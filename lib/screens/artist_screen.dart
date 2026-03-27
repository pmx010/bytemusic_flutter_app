import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ArtistScreen extends StatelessWidget {
  final String artistName;
  final Color accentColor;

  const ArtistScreen({
    super.key,
    this.artistName = 'Luna Ray',
    this.accentColor = const Color(0xFF667EEA),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(child: _buildStats()),
          SliverToBoxAdapter(child: _buildActions()),
          SliverToBoxAdapter(child: _buildPopularSection()),
          SliverToBoxAdapter(child: _buildAlbumsSection()),
          SliverToBoxAdapter(child: _buildRelatedArtists()),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 340,
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
                icon: const Icon(Icons.share_outlined),
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
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(Icons.person_rounded, color: AppColors.white, size: 70),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    artistName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '2.5M monthly listeners',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _StatChip(label: 'FOLLOWERS', value: '2.5M'),
          const SizedBox(width: 12),
          _StatChip(label: 'FOLLOWING', value: '156'),
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
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow_rounded, color: AppColors.background, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Play',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.background,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white.withOpacity(0.2)),
            ),
            child: const Icon(Icons.shuffle_rounded, color: AppColors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white.withOpacity(0.2)),
            ),
            child: const Icon(Icons.favorite_border_rounded, color: AppColors.white, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSection() {
    final popularTracks = [
      {'title': 'Midnight Dreams', 'plays': '45M', 'isPlaying': true},
      {'title': 'Moonlight Serenade', 'plays': '38M', 'isPlaying': false},
      {'title': 'Crystal Sky', 'plays': '32M', 'isPlaying': false},
      {'title': 'Starlight', 'plays': '28M', 'isPlaying': false},
      {'title': 'Echoes', 'plays': '22M', 'isPlaying': false},
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Popular', style: AppTextStyles.title),
          const SizedBox(height: 16),
          ...popularTracks.asMap().entries.map((entry) {
            final index = entry.key;
            final track = entry.value;
            return _PopularTrackRow(
              index: index + 1,
              title: track['title'] as String,
              plays: track['plays'] as String,
              isPlaying: track['isPlaying'] == true,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAlbumsSection() {
    final albums = [
      {'title': 'Dreamscape', 'year': '2024', 'color': const Color(0xFFF093FB)},
      {'title': 'Midnight', 'year': '2022', 'color': const Color(0xFF667EEA)},
      {'title': 'Echoes', 'year': '2020', 'color': const Color(0xFF4FACFE)},
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Albums', style: AppTextStyles.title),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: albums.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final album = albums[index];
                return _AlbumItem(
                  title: album['title'] as String,
                  year: album['year'] as String,
                  color: album['color'] as Color,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedArtists() {
    final artists = [
      {'name': 'Neon Pulse', 'color': const Color(0xFFF093FB)},
      {'name': 'Celestial', 'color': const Color(0xFF4FACFE)},
      {'name': 'Coastal', 'color': const Color(0xFF43E97B)},
      {'name': 'Deep Blue', 'color': const Color(0xFF667EEA)},
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Related Artists', style: AppTextStyles.title),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: artists.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final artist = artists[index];
                return _RelatedArtistItem(
                  name: artist['name'] as String,
                  color: artist['color'] as Color,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 10, color: AppColors.textTertiary, letterSpacing: 1)),
        ],
      ),
    );
  }
}

class _PopularTrackRow extends StatelessWidget {
  final int index;
  final String title;
  final String plays;
  final bool isPlaying;

  const _PopularTrackRow({
    required this.index,
    required this.title,
    required this.plays,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isPlaying ? AppColors.accent.withOpacity(0.15) : AppColors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: isPlaying ? Border.all(color: AppColors.accent.withOpacity(0.3)) : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              '$index',
              style: TextStyle(fontSize: 14, color: AppColors.textTertiary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isPlaying ? FontWeight.w600 : FontWeight.w400,
                    color: isPlaying ? AppColors.accent : AppColors.white,
                  ),
                ),
                Text(
                  '$plays plays',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          if (isPlaying)
            const Icon(Icons.equalizer_rounded, color: AppColors.accent, size: 20),
          const SizedBox(width: 8),
          Icon(Icons.more_vert, color: AppColors.textTertiary, size: 20),
        ],
      ),
    );
  }
}

class _AlbumItem extends StatelessWidget {
  final String title;
  final String year;
  final Color color;

  const _AlbumItem({
    required this.title,
    required this.year,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.album_rounded, color: AppColors.white, size: 48),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.white),
        ),
        Text(year, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _RelatedArtistItem extends StatelessWidget {
  final String name;
  final Color color;

  const _RelatedArtistItem({
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person_rounded, color: AppColors.white, size: 32),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            name,
            style: const TextStyle(fontSize: 12, color: AppColors.white),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

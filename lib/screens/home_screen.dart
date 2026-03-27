import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/music_card.dart';
import 'player_screen.dart';
import 'playlist_detail_screen.dart';
import 'album_detail_screen.dart';
import 'artist_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 28),
                    _buildGreeting(),
                    const SizedBox(height: 6),
                    _buildSubGreeting(),
                    const SizedBox(height: 24),
                    _buildSearchBar(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: _buildRecentlyPlayed(context)),
            SliverToBoxAdapter(child: _buildMadeForYou(context)),
            SliverToBoxAdapter(child: _buildTrendingSection(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }

  void _navigateToPlayer(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const PlayerScreen()));
  }

  void _navigateToPlaylistDetail(BuildContext context, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PlaylistDetailScreen(playlistName: title)));
  }

  void _navigateToAlbumDetail(BuildContext context, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AlbumDetailScreen(albumName: title)));
  }

  void _navigateToArtist(BuildContext context, String name) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ArtistScreen(artistName: name)));
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: const Icon(Icons.headphones_rounded, color: AppColors.white, size: 26),
        ),
        Row(
          children: [
            _buildIconButton(Icons.notifications_outlined),
            const SizedBox(width: 10),
            _buildIconButton(Icons.settings_outlined),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: AppColors.white.withOpacity(0.7), size: 22),
    );
  }

  Widget _buildGreeting() {
    final hour = DateTime.now().hour;
    String greeting = hour < 12 ? 'Good Morning' : (hour < 17 ? 'Good Afternoon' : 'Good Evening');
    return Text(greeting, style: AppTextStyles.heading);
  }

  Widget _buildSubGreeting() {
    return Text('What would you like to listen to?', style: AppTextStyles.bodySecondary);
  }

  Widget _buildSearchBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(Icons.search_rounded, color: AppColors.textTertiary, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text('Search songs, artists...', style: TextStyle(fontSize: 15, color: AppColors.textTertiary))),
          Container(
            width: 44, height: 44, margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.tune_rounded, color: AppColors.textTertiary, size: 20),
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }

  Widget _buildRecentlyPlayed(BuildContext context) {
    final items = [
      {'title': 'Chill Vibes', 'artist': 'Various', 'color': const Color(0xFF667EEA)},
      {'title': 'Focus Flow', 'artist': 'Instrumental', 'color': const Color(0xFFF093FB)},
      {'title': 'Party Mix', 'artist': 'DJ Set', 'color': const Color(0xFF4FACFE)},
      {'title': 'Acoustic', 'artist': 'Live', 'color': const Color(0xFF43E97B)},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recently Played', style: AppTextStyles.title),
              Icon(Icons.arrow_forward_rounded, color: AppColors.textTertiary, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final item = items[index];
                return AlbumCard(
                  title: item['title'] as String,
                  artist: item['artist'] as String,
                  cardColor: item['color'] as Color,
                  cardWidth: 140,
                  imageHeight: 100,
                  onTap: () => _navigateToPlaylistDetail(context, item['title'] as String),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMadeForYou(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Made for You', style: AppTextStyles.title),
              Icon(Icons.arrow_forward_rounded, color: AppColors.textTertiary, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: MusicCard(
                    title: 'Daily Mix 1',
                    subtitle: '5 songs',
                    gradientColors: [const Color(0xFF667EEA), const Color(0xFF764BA2)],
                    onTap: () => _navigateToPlaylistDetail(context, 'Daily Mix 1'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MusicCard(
                    title: 'Discover',
                    subtitle: '12 songs',
                    gradientColors: [const Color(0xFFF093FB), const Color(0xFFF5576C)],
                    onTap: () => _navigateToPlaylistDetail(context, 'Discover'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection(BuildContext context) {
    final songs = [
      {'title': 'Midnight Dreams', 'artist': 'Luna Ray', 'duration': '3:42'},
      {'title': 'Electric Heart', 'artist': 'Neon Pulse', 'duration': '4:15'},
      {'title': 'Summer Haze', 'artist': 'Coastal', 'duration': '3:28'},
      {'title': 'Starlight', 'artist': 'Celestial', 'duration': '3:56'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trending Now', style: AppTextStyles.title),
          const SizedBox(height: 16),
          ...songs.map((s) => MusicTrackTile(
            title: s['title']!,
            artist: s['artist']!,
            duration: s['duration']!,
            onTap: () => _navigateToPlayer(context),
          )),
        ],
      ),
    );
  }
}

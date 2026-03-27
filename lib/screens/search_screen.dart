import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'artist_screen.dart';
import 'album_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
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
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
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
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: const Text('Search', style: AppTextStyles.headingLarge),
            ),
          ),
          const SizedBox(height: 24),
          FadeTransition(
            opacity: _fadeAnimation,
            child: _buildSearchCard(),
          ),
          const SizedBox(height: 32),
          FadeTransition(
            opacity: _fadeAnimation,
            child: _buildSectionTitle('Browse Categories'),
          ),
          const SizedBox(height: 20),
          FadeTransition(
            opacity: _fadeAnimation,
            child: _buildCategoriesGrid(),
          ),
          const SizedBox(height: 32),
          FadeTransition(
            opacity: _fadeAnimation,
            child: _buildSectionTitle('Popular Artists'),
          ),
          const SizedBox(height: 20),
          FadeTransition(
            opacity: _fadeAnimation,
            child: _buildArtistsList(),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
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
          Expanded(
            child: Text(
              'Search songs, artists...',
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textTertiary,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.tune_rounded,
              color: AppColors.textTertiary,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.title),
        Icon(
          Icons.arrow_forward_rounded,
          color: AppColors.textTertiary,
          size: 20,
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid() {
    final categories = [
      _CategoryData('Pop', const Color(0xFFE91E63), Icons.music_note_rounded),
      _CategoryData('Hip Hop', const Color(0xFF9C27B0), Icons.headphones_rounded),
      _CategoryData('Rock', const Color(0xFF795548), Icons.bolt_rounded),
      _CategoryData('Jazz', const Color(0xFF607D8B), Icons.piano_rounded),
      _CategoryData('Electronic', const Color(0xFF00BCD4), Icons.waves_rounded),
      _CategoryData('Classical', const Color(0xFF3F51B5), Icons.music_note_rounded),
      _CategoryData('R&B', const Color(0xFFFF9800), Icons.mic_rounded),
      _CategoryData('Indie', const Color(0xFF4CAF50), Icons.album_rounded),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.6,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryCard(
          name: category.name,
          color: category.color,
          icon: category.icon,
          onTap: () => _navigateToAlbumDetail(context, '${category.name} Mix'),
        );
      },
    );
  }

  Widget _buildArtistsList() {
    final artists = [
      _ArtistData('Luna Ray', const Color(0xFF667EEA)),
      _ArtistData('Neon Pulse', const Color(0xFFF093FB)),
      _ArtistData('Coastal', const Color(0xFF4FACFE)),
      _ArtistData('Celestial', const Color(0xFF43E97B)),
      _ArtistData('Deep Blue', const Color(0xFF667EEA)),
      _ArtistData('Urban Echo', const Color(0xFFF093FB)),
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: artists.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final artist = artists[index];
          return _ArtistCircle(
            name: artist.name,
            color: artist.color,
            onTap: () => _navigateToArtist(context, artist.name),
          );
        },
      ),
    );
  }

  void _navigateToArtist(BuildContext context, String name) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ArtistScreen(artistName: name)));
  }

  void _navigateToAlbumDetail(BuildContext context, String name) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AlbumDetailScreen(albumName: name)));
  }
}

class _CategoryData {
  final String name;
  final Color color;
  final IconData icon;

  const _CategoryData(this.name, this.color, this.icon);
}

class _ArtistData {
  final String name;
  final Color color;

  const _ArtistData(this.name, this.color);
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.name,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative icon
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                icon,
                size: 60,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: Colors.white.withOpacity(0.9),
                    size: 28,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
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
}

class _ArtistCircle extends StatelessWidget {
  final String name;
  final Color color;
  final VoidCallback onTap;

  const _ArtistCircle({
    required this.name,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 76,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

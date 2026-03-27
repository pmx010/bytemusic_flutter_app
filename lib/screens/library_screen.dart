import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'playlist_detail_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Your Library', style: AppTextStyles.heading),
              IconButton(
                icon: Icon(Icons.add, color: AppColors.textSecondary),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _Chip('Playlists', active: true),
              const SizedBox(width: 8),
              _Chip('Albums'),
              const SizedBox(width: 8),
              _Chip('Liked'),
            ],
          ),
          const SizedBox(height: 24),
          ...List.generate(8, (index) => _LibraryItem(
            index: index,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PlaylistDetailScreen(playlistName: 'Playlist ${index + 1}'))),
          )),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool active;
  const _Chip(this.label, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.accent : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
        border: active ? null : Border.all(color: AppColors.borderSubtle),
      ),
      child: Text(label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: active ? AppColors.white : AppColors.textSecondary,
          )),
    );
  }
}

class _LibraryItem extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  const _LibraryItem({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.music_note, color: AppColors.textTertiary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Playlist ${index + 1}', style: AppTextStyles.body),
                  const SizedBox(height: 4),
                  Text('Playlist · ${12 + index} songs',
                      style: AppTextStyles.captionSecondary),
                ],
              ),
            ),
            Icon(Icons.more_vert, color: AppColors.textTertiary, size: 20),
          ],
        ),
      ),
    );
  }
}

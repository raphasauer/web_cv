import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/resume_data.dart';
import 'section_title.dart';

class AppsSection extends StatelessWidget {
  const AppsSection({super.key});

  static const double _cardWidth = 560;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final mobileContentWidth = screenWidth - 40; // 20px padding on each side

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Apps I\'ve Built',
            subtitle: 'Projects that showcase my expertise',
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: ResumeData.apps.map((app) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: isMobile ? mobileContentWidth : _cardWidth,
                  maxWidth: isMobile ? mobileContentWidth : _cardWidth,
                  minHeight: 320,
                ),
                child: IntrinsicHeight(
                  child: AppCard(app: app),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class AppCard extends StatefulWidget {
  final Map<String, dynamic> app;

  const AppCard({super.key, required this.app});

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = Color(widget.app['color'] as int);
    final logoPath = widget.app['logo'] as String;
    final isNetworkImage = widget.app['isNetworkImage'] == true;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -8.0 : 0.0),
        decoration: BoxDecoration(
          color: AppTheme.cardColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? color.withOpacity(0.5) : Colors.white.withOpacity(0.1),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? color.withOpacity(0.3)
                  : Colors.black.withOpacity(0.2),
              blurRadius: _isHovered ? 30 : 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // App Logo Container
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: AppLogo(
                        logoPath: logoPath,
                        isNetworkImage: isNetworkImage,
                        appName: widget.app['name'],
                        fallbackColor: color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.app['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.app['platform'],
                          style: TextStyle(
                            fontSize: 12,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.app['description'],
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.rocket_launch, color: color, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.app['achievement'],
                        style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.people, color: Colors.white.withOpacity(0.5), size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      widget.app['users'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget to display app logo with loading and error handling
class AppLogo extends StatelessWidget {
  final String logoPath;
  final bool isNetworkImage;
  final String appName;
  final Color fallbackColor;

  const AppLogo({
    super.key,
    required this.logoPath,
    required this.isNetworkImage,
    required this.appName,
    required this.fallbackColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isNetworkImage) {
      return Image.network(
        logoPath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackIcon();
        },
      );
    } else {
      return Image.asset(
        logoPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackIcon();
        },
      );
    }
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      color: fallbackColor.withOpacity(0.2),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(fallbackColor),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return Container(
      color: fallbackColor.withOpacity(0.2),
      child: Center(
        child: Text(
          appName.isNotEmpty ? appName[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: fallbackColor,
          ),
        ),
      ),
    );
  }
}
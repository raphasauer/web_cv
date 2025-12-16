import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/resume_data.dart';
import 'section_title.dart';

class WorkHistorySection extends StatelessWidget {
  const WorkHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Work History',
            subtitle: 'My professional journey',
          ),
          const SizedBox(height: 60),
          ...ResumeData.workHistory.asMap().entries.map((entry) {
            return TimelineItem(
              job: entry.value,
              isFirst: entry.key == 0,
              isLast: entry.key == ResumeData.workHistory.length - 1,
              isMobile: isMobile,
            );
          }),
        ],
      ),
    );
  }
}

class TimelineItem extends StatefulWidget {
  final Map<String, dynamic> job;
  final bool isFirst;
  final bool isLast;
  final bool isMobile;

  const TimelineItem({
    super.key,
    required this.job,
    required this.isFirst,
    required this.isLast,
    required this.isMobile,
  });

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Show fewer highlights on mobile to prevent overflow
    final allHighlights = widget.job['highlights'] as List<String>;
    final highlights = widget.isMobile 
        ? allHighlights.take(1).toList() 
        : allHighlights.take(3).toList();

    final timelineDot = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isHovered ? 24 : 20,
      height: _isHovered ? 24 : 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(
              _isHovered ? 0.6 : 0.3,
            ),
            blurRadius: _isHovered ? 15 : 8,
            spreadRadius: _isHovered ? 3 : 1,
          ),
        ],
      ),
    );

    final jobCard = Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppTheme.cardColor.withOpacity(_isHovered ? 0.9 : 0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryColor.withOpacity(0.5)
                : Colors.white.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppTheme.primaryColor.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2),
              blurRadius: _isHovered ? 30 : 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.job['period'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        widget.job['location'],
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.job['role'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: widget.isMobile ? null : TextOverflow.ellipsis,
              maxLines: widget.isMobile ? null : 2,
            ),
            const SizedBox(height: 4),
            Text(
              widget.job['company'],
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
              overflow: widget.isMobile ? null : TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Text(
              widget.job['description'],
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            ...highlights.map(
              (highlight) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        highlight,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                        maxLines: widget.isMobile ? null : 2,
                        overflow: widget.isMobile ? null : TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (widget.isMobile) {
      const double dotTopPosition = 24;
      const double dotSize = 20;
      const double dotCenterPosition = dotTopPosition + (dotSize / 2);

      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Stack(
          children: [
            // Top line (from top to dot) - hidden for first item
            if (!widget.isFirst)
              Positioned(
                left: 19,
                top: 0,
                child: Container(
                  width: 2,
                  height: dotCenterPosition,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryColor.withOpacity(0.3),
                        AppTheme.primaryColor,
                      ],
                    ),
                  ),
                ),
              ),
            // Bottom line (from dot to bottom) - hidden for last item
            if (!widget.isLast)
              Positioned(
                left: 19,
                top: dotCenterPosition,
                bottom: 0,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.primaryColor.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),
            // Content row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(top: dotTopPosition),
                    child: Center(child: timelineDot),
                  ),
                ),
                Expanded(child: jobCard),
              ],
            ),
          ],
        ),
      );
    }

    // Desktop layout - original structure
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 60,
              child: Column(
                children: [
                  if (!widget.isFirst)
                    Expanded(
                      child: Container(
                        width: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppTheme.primaryColor.withOpacity(0.3),
                              AppTheme.primaryColor,
                            ],
                          ),
                        ),
                      ),
                    ),
                  timelineDot,
                  if (!widget.isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppTheme.primaryColor,
                              AppTheme.primaryColor.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(child: jobCard),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import '../theme/app_theme.dart';
import '../data/resume_data.dart';
import 'section_title.dart';

class WorldMapSection extends StatefulWidget {
  const WorldMapSection({super.key});

  @override
  State<WorldMapSection> createState() => _WorldMapSectionState();
}

class _WorldMapSectionState extends State<WorldMapSection> {
  String? _selectedCountry;
  String? _hoveredCountry;

  // Build the color map for countries
  Map<String, Color> _buildCountryColors() {
    final Map<String, Color> colors = {};
    
    for (var country in ResumeData.collaborationCountries) {
      final code = country['code']!.toLowerCase();
      colors[code] = _hoveredCountry == country['name']
          ? AppTheme.secondaryColor
          : AppTheme.primaryColor;
    }
    
    return colors;
  }

  String? _getCountryNameFromCode(String code) {
    try {
      final country = ResumeData.collaborationCountries.firstWhere(
        (c) => c['code']!.toLowerCase() == code.toLowerCase(),
      );
      return country['name'];
    } catch (e) {
      return null;
    }
  }

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
            title: 'Global Collaboration',
            subtitle: 'Working with talented people across the world',
          ),
          const SizedBox(height: 60),
          Container(
            constraints: const BoxConstraints(maxWidth: 1100),
            decoration: AppTheme.glassDecoration,
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                // Selected country indicator
                if (_selectedCountry != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          'Collaborated with teams in $_selectedCountry',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () => setState(() => _selectedCountry = null),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // World Map
                AspectRatio(
                  aspectRatio: 2,
                  child: SimpleMap(
                    instructions: SMapWorld.instructions,
                    defaultColor: AppTheme.cardColor,
                    countryBorder: CountryBorder(
                      color: Colors.white.withOpacity(0.1),
                      width: 0.5,
                    ),
                    colors: _buildCountryColors(),
                    callback: (id, name, tapDetails) {
                      final countryName = _getCountryNameFromCode(id);
                      if (countryName != null) {
                        setState(() {
                          _selectedCountry = countryName;
                        });
                      }
                    },
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Legend
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem(
                      AppTheme.primaryColor,
                      'Collaboration Countries',
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Country tags
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: ResumeData.collaborationCountries.map((country) {
                    final name = country['name']!;
                    final isSelected = _selectedCountry == name;
                    final isHovered = _hoveredCountry == name;
                    
                    return MouseRegion(
                      onEnter: (_) => setState(() => _hoveredCountry = name),
                      onExit: (_) => setState(() => _hoveredCountry = null),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCountry = name),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: isSelected || isHovered
                                ? AppTheme.primaryGradient
                                : null,
                            color: isSelected || isHovered
                                ? null
                                : AppTheme.cardColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected || isHovered
                                  ? Colors.transparent
                                  : AppTheme.primaryColor.withOpacity(0.3),
                            ),
                            boxShadow: isSelected || isHovered
                                ? [
                                    BoxShadow(
                                      color: AppTheme.primaryColor.withOpacity(0.4),
                                      blurRadius: 10,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelected)
                                const Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              Text(
                                name,
                                style: TextStyle(
                                  color: isSelected || isHovered
                                      ? Colors.white
                                      : AppTheme.textSecondary,
                                  fontSize: 12,
                                  fontWeight: isSelected || isHovered
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: color == AppTheme.primaryColor
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 6,
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
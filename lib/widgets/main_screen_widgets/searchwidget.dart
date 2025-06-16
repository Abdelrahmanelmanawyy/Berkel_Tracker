

import 'package:berkel_tracking_servise/constants/dataset.dart';
import 'package:flutter/material.dart';

// Modern Metro Station Search Widget
class MetroStationSearchWidget extends StatefulWidget {
  final void Function(Station station)? onStationSelected;

  const MetroStationSearchWidget({super.key, this.onStationSelected});

  @override
  State<MetroStationSearchWidget> createState() => _MetroStationSearchWidgetState();
}

class _MetroStationSearchWidgetState extends State<MetroStationSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  late List<Station> _allStations;

  List<Station> _filteredStations = [];
  String _selectedLine = "All";
  List<String> _metroLines = ["All"];
  List<String> _uniqueLines = [];

  @override
  void initState() {
    super.initState();
    _allStations = StationData.getAllStations();
    _initializeMetroLines();
    _filteredStations = _allStations;
  }

  void _initializeMetroLines() {
    Set<String> allLines = {};
    for (var station in _allStations) {
      List<String> lines = station.category.split(',').map((e) => e.trim()).toList();
      allLines.addAll(lines);
    }
    _uniqueLines = allLines.toList();

    List<String> metroOnly = _uniqueLines
        .where((line) =>
            line.startsWith('M') ||
            line.startsWith('F') ||
            line.startsWith('T') ||
            line.startsWith('B'))
        .toList()
      ..sort();

    List<String> otherCategories = _uniqueLines
        .where((line) =>
            !line.startsWith('M') &&
            !line.startsWith('F') &&
            !line.startsWith('T') &&
            !line.startsWith('B'))
        .toList()
      ..sort();

    _metroLines = ["All", ...metroOnly, ...otherCategories];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterStations(String query) {
    List<Station> results;

    if (query.isEmpty) {
      results = _selectedLine == "All"
          ? _allStations
          : _allStations.where((station) => station.category
              .split(',')
              .map((e) => e.trim())
              .contains(_selectedLine)).toList();
    } else {
      results = _allStations.where((station) {
        final matchesQuery = station.name.toLowerCase().contains(query.toLowerCase()) ||
            station.id.toString().contains(query);
        final matchesLine = _selectedLine == "All" ||
            station.category
                .split(',')
                .map((e) => e.trim())
                .contains(_selectedLine);
        return matchesQuery && matchesLine;
      }).toList();
    }

    setState(() {
      _filteredStations = results;
    });
  }

  void _filterByLine(String line) {
    setState(() {
      _selectedLine = line;
      _filterStations(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Modern Search and Filters Container
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon - matching the design pattern
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF06B6D4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF06B6D4).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.train_rounded,
                        size: 20,
                        color: Color(0xFF06B6D4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'İstasyon Arama',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 18),
                
                // Modern Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterStations,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                    decoration: InputDecoration(
                      hintText: 'İstasyon adı veya kod girin...',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFF06B6D4),
                        size: 20,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.clear_rounded,
                                  size: 16,
                                ),
                                color: Colors.grey.shade600,
                                onPressed: () {
                                  _searchController.clear();
                                  _filterStations('');
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Modern Line Filters
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _metroLines.map((line) {
                      final isSelected = _selectedLine == line;
                      final lineColor = line == "All" 
                          ? const Color(0xFF6366F1)
                          : StationData.getLineColor(line);
                      
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => _filterByLine(line),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? lineColor.withOpacity(0.1)
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected 
                                      ? lineColor.withOpacity(0.3)
                                      : Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                line,
                                style: TextStyle(
                                  color: isSelected ? lineColor : Colors.grey.shade700,
                                  fontWeight: isSelected 
                                      ? FontWeight.w600 
                                      : FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Modern Station List
        Expanded(
          child: _filteredStations.isEmpty
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: Color(0xFF9CA3AF),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'İstasyon bulunamadı',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Farklı arama terimleri deneyiniz',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: _filteredStations.length,
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.grey.shade300,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final station = _filteredStations[index];
                      String displayLine = _selectedLine != "All" &&
                              station.category.contains(_selectedLine)
                          ? _selectedLine
                          : station.category.split(',').first.trim();

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            if (widget.onStationSelected != null) {
                              widget.onStationSelected!(station);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // Modern station icon
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: StationData.getLineColor(displayLine).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: StationData.getLineColor(displayLine).withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      displayLine.length > 3 ? displayLine[0] : displayLine,
                                      style: TextStyle(
                                        color: StationData.getLineColor(displayLine),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(width: 16),
                                
                                // Station info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        station.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1F2937),
                                          letterSpacing: -0.2,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              'Kod: ${station.id}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: station.category
                                                    .split(',')
                                                    .map((e) => e.trim())
                                                    .map((line) => Container(
                                                          margin: const EdgeInsets.only(right: 4),
                                                          padding: const EdgeInsets.symmetric(
                                                            horizontal: 6,
                                                            vertical: 2,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: StationData.getLineColor(line),
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                          child: Text(
                                                            line,
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Navigation arrow
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    color: Colors.grey.shade500,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hungry/models/core/recipe.dart';

class ClimateFootprintTile extends StatelessWidget {
  final ClimateFootprint? data;

  ClimateFootprintTile({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Center(
        child: Text('No climate footprint data available.'),
      );
    }

    // Use data! to indicate that data is non-null beyond this point
    return Container(
      // Your existing code, replacing data with data!
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[350]!, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Results',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // Climate Footprint Summary
          Text(
            'The climate footprint of ${data!.productName} is ${data!.totalClimateImpact?.toStringAsFixed(3)} kg CO₂e/kg.',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20),
          // Subtitle
          Text(
            'The table below shows this result separated by fundamental activity.',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20),
          // Data Table
          _buildDataTable(data!),
        ],
      ),
    );
  }

  Widget _buildDataTable(ClimateFootprint data) {
    // Use data directly since it's guaranteed to be non-null
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'Fundamental Activity',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Climate Impact',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Share of Total',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
      rows: _buildDataRows(data),
    );
  }

  List<DataRow> _buildDataRows(ClimateFootprint data) {
    final activities = data.activities ?? [];

    List<DataRow> rows = activities.map((activity) {
      return DataRow(
        cells: [
          DataCell(
            Text(
              activity.name ?? '',
              style: TextStyle(
                fontFamily: 'Inter',
              ),
            ),
          ),
          DataCell(
            Text(
              '${activity.climateImpact?.toStringAsFixed(4) ?? '0'} kg CO₂e/kg',
              style: TextStyle(
                fontFamily: 'Inter',
              ),
            ),
          ),
          DataCell(
            Text(
              '${activity.shareOfTotal?.toStringAsFixed(2) ?? '0'}%',
              style: TextStyle(
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      );
    }).toList();

    // Add total row
    rows.add(
      DataRow(
        cells: [
          DataCell(
            Text(
              'Total:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
          DataCell(
            Text(
              '${data.totalClimateImpact?.toStringAsFixed(3)} kg CO₂e/kg',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
          DataCell(Text('')),
        ],
      ),
    );

    return rows;
  }
}

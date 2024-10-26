import 'package:flutter/material.dart';

// Main screen for carbon footprint analysis
class CarbonFootprintScreen extends StatelessWidget {
  const CarbonFootprintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ensures content is rendered within safe area, avoiding system UI
      body: SafeArea(
        child: Padding(
          // Adds padding around the content
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Aligns children to stretch across the screen
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title of the screen
              const Text(
                'Carbon Footprint Analysis',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24), // Adds space between elements

              // Card displaying the user's carbon footprint
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Carbon Footprint:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8), // Space between text elements
                      Text(
                        '58%', // Placeholder for carbon footprint value
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24), // Adds space before recommendations

              // Recommendations section header
              const Text(
                'Recommendations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16), // Space before recommendations list

              // Building individual recommendations
              _buildRecommendation(
                'Reduce your carbon footprint by 1%',
                'Plant a tree in your backyard',
              ),
              _buildRecommendation(
                'Reduce your carbon footprint by 2%',
                'Take public transportation to work',
              ),
              _buildRecommendation(
                'Reduce your carbon footprint by 3%',
                'Switch to renewable energy',
              ),
              const SizedBox(height: 24), // Space before footprint history

              // Footprint history section header
              const Text(
                'Footprint History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16), // Space before history items

              // Building history items
              _buildHistoryItem('August 6, 2024', '58%'),
              _buildHistoryItem('July 30, 2024', '30%'),
              _buildHistoryItem('June 30, 2024', '78%'),
              const Spacer(), // Takes up available space to push button to the bottom

              // Back button to navigate to the previous screen
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF00D37F), // Custom background color
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Vertical padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: const Text(
                  'Go Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build individual recommendation items
  Widget _buildRecommendation(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 12.0), // Space below each recommendation
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns items to the start
        children: [
          const Text('• '), // Bullet point
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligns text to the start
              children: [
                Text(
                  title, // Recommendation title
                  style: const TextStyle(
                    fontWeight: FontWeight.w500, // Semi-bold text
                  ),
                ),
                Text(
                  description, // Recommendation description
                  style: TextStyle(
                    color: Colors.grey[600], // Gray text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to build individual history items
  Widget _buildHistoryItem(String date, String percentage) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 12.0), // Space below each history item
      child: Row(
        children: [
          const Text('• '), // Bullet point
          Text(
            date, // Date of the footprint record
            style: const TextStyle(
              fontWeight: FontWeight.w500, // Semi-bold text
            ),
          ),
          const Spacer(), // Takes up available space to align percentage to the right
          Text(
            percentage, // Carbon footprint percentage
            style: const TextStyle(
              fontWeight: FontWeight.w500, // Semi-bold text
            ),
          ),
        ],
      ),
    );
  }
}

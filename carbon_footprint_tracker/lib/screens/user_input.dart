import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'analysis.dart';

// Main widget for the Daily Habits screen
class DailyHabitsScreen extends StatefulWidget {
  const DailyHabitsScreen({super.key});

  @override
  State<DailyHabitsScreen> createState() => _DailyHabitsScreenState();
}

// State class for DailyHabitsScreen
class _DailyHabitsScreenState extends State<DailyHabitsScreen> {
  // Key for form validation
  final _formKey = GlobalKey<FormState>();
  // Controller for scrolling
  final _scrollController = ScrollController();

  // Text editing controllers for input fields
  final _devicesController = TextEditingController();
  final _hoursController = TextEditingController();
  final _groceryController = TextEditingController();
  final _transportController = TextEditingController();
  final _clothesController = TextEditingController();
  final _mealsController = TextEditingController();

  // Focus nodes for input fields to manage focus
  final _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Adding listeners to focus nodes to scroll to the focused input field
    for (var node in _focusNodes) {
      node.addListener(() {
        if (node.hasFocus) {
          _scrollToFocusedField(node);
        }
      });
    }
  }

  // Function to scroll to the focused input field
  void _scrollToFocusedField(FocusNode focusNode) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return; // Check if the widget is still in the tree

      final RenderObject? renderObject = context.findRenderObject();
      RenderAbstractViewport.of(renderObject); // Get the viewport

      // Animate the scroll to the focused field
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent *
            (_focusNodes.indexOf(focusNode) / _focusNodes.length),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    // Dispose of controllers and focus nodes to free up resources
    _scrollController.dispose();
    for (var controller in [
      _devicesController,
      _hoursController,
      _groceryController,
      _transportController,
      _clothesController,
      _mealsController,
    ]) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Dismiss keyboard when tapping outside of the text fields
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController, // Attach scroll controller
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, // Assign form key for validation
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Analyse Your Daily Habits',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    // Input fields for various habits
                    _buildInputField(
                      'How many electronic devices do you own?',
                      _devicesController,
                      'Number',
                      _focusNodes[0],
                      TextInputType.number,
                      _focusNodes[1],
                    ),
                    _buildInputField(
                      'How many hours a day do you spend in front of your device?',
                      _hoursController,
                      'Hours',
                      _focusNodes[1],
                      const TextInputType.numberWithOptions(decimal: true),
                      _focusNodes[2],
                    ),
                    _buildInputField(
                      'Monthly grocery spending',
                      _groceryController,
                      'Amount in USD',
                      _focusNodes[2],
                      const TextInputType.numberWithOptions(decimal: true),
                      _focusNodes[3],
                    ),
                    _buildInputField(
                      'Monthly transportation expenditure',
                      _transportController,
                      'Amount in USD',
                      _focusNodes[3],
                      const TextInputType.numberWithOptions(decimal: true),
                      _focusNodes[4],
                    ),
                    _buildInputField(
                      'How many clothes do you buy monthly?',
                      _clothesController,
                      'Number',
                      _focusNodes[4],
                      TextInputType.number,
                      _focusNodes[5],
                    ),
                    _buildInputField(
                      'Weekly number of meals consumed',
                      _mealsController,
                      'Number',
                      _focusNodes[5],
                      TextInputType.number,
                      null,
                    ),
                    const SizedBox(height: 24),
                    // Submit button for calculating carbon footprint
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00D37F),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Calculate Carbon Footprint',
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
          ),
        ),
      ),
    );
  }

  // Helper function to build input fields
  Widget _buildInputField(
    String label,
    TextEditingController controller,
    String hint,
    FocusNode focusNode,
    TextInputType keyboardType,
    FocusNode? nextFocusNode,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            textInputAction: nextFocusNode != null
                ? TextInputAction.next
                : TextInputAction.done,
            onFieldSubmitted: (_) {
              // Move to the next focus node if it exists
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFE8F5F1),
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[600],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            // Validation for input fields
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a value'; // Check for empty input
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number'; // Check for valid number
              }
              return null; // Validation passed
            },
          ),
        ],
      ),
    );
  }

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Validate form
      FocusScope.of(context).unfocus(); // Dismiss keyboard
      // Navigate to Carbon Footprint screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CarbonFootprintScreen(),
        ),
      );
    }
  }
}

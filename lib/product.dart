import 'dart:ui';
import 'package:flutter/material.dart';

class ProductOrderPage extends StatefulWidget {
  final String productName;
  final String imageUrl;
  final double rating;
  final int ratingCount;
  final String description;
  final List<String> fillingOptions;
  final List<String> milkOptions;
  final List<String> sugarOptions;

  const ProductOrderPage({
    Key? key,
    required this.productName,
    required this.imageUrl,
    required this.rating,
    required this.ratingCount,
    required this.description,
    required this.fillingOptions,
    required this.milkOptions,
    required this.sugarOptions,
  }) : super(key: key);

  @override
  _ProductOrderPageState createState() => _ProductOrderPageState();
}

class _ProductOrderPageState extends State<ProductOrderPage> {
  late String _selectedFilling;
  late String _selectedMilk;
  late String _selectedSugar;
  bool _highPriority = false;

  @override
  void initState() {
    super.initState();
    _selectedFilling = widget.fillingOptions.first;
    _selectedMilk = widget.milkOptions.first;
    _selectedSugar = widget.sugarOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildScrollableContent(),
          _buildFloatingNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset(widget.imageUrl, alignment: Alignment.center)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductHeader(),
                const SizedBox(height: 15),
                _buildDescription(),
                const SizedBox(height: 20),
                _buildFillingOptions(),
                const SizedBox(height: 20),
                _buildMilkOptions(),
                const SizedBox(height: 20),
                _buildSugarOptions(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.productName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber),
            Text(
              '${widget.rating}',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              ' (${widget.ratingCount})',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.description,
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildFillingOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choice of Cup Filling',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Wrap(
          spacing: 8,
          children: widget.fillingOptions.map((filling) {
            return ChoiceChip(
              label: Text(filling),
              selected: _selectedFilling == filling,
              onSelected: (selected) {
                setState(() {
                  _selectedFilling = filling;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMilkOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choice of Milk', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        _buildOptionGrid(widget.milkOptions, _selectedMilk, (value) {
          setState(() {
            _selectedMilk = value;
          });
        }),
      ],
    );
  }

  Widget _buildSugarOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choice of Sugar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        _buildOptionGrid(widget.sugarOptions, _selectedSugar, (value) {
          setState(() {
            _selectedSugar = value;
          });
        }),
      ],
    );
  }

  Widget _buildOptionGrid(List<String> options, String selectedValue, Function(String) onChanged) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      physics: const NeverScrollableScrollPhysics(),
      children: options.map((option) => _buildOptionTile(option, selectedValue, onChanged)).toList(),
    );
  }

  Widget _buildOptionTile(String option, String selectedValue, Function(String) onChanged) {
    bool isSelected = selectedValue == option;
    return GestureDetector(
      onTap: () => onChanged(option),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(option, style: const TextStyle(color: Colors.white)),
            ),
            _buildToggleSwitch(isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSwitch(bool isSelected) {
    return Container(
      width: 30,
      height: 15,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isSelected ? Colors.green : Colors.grey[700],
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            left: isSelected ? 15 : 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavigationBar() {
    return Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHighPriorityCheckbox(),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHighPriorityCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _highPriority,
          onChanged: (bool? value) {
            setState(() {
              _highPriority = value!;
            });
          },
        ),
        const Text(
          'High Priority',
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 8),
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle the submit action here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}